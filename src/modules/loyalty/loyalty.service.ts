import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { LoyaltyAccount, LoyaltyTier } from './entities/loyalty-account.entity';
import { LoyaltyTransaction, LoyaltyTransactionType } from './entities/loyalty-transaction.entity';
import { LoyaltyReward } from './entities/loyalty-reward.entity';

@Injectable()
export class LoyaltyService {
  constructor(
    @InjectRepository(LoyaltyAccount)
    private loyaltyAccountRepository: Repository<LoyaltyAccount>,
    @InjectRepository(LoyaltyTransaction)
    private loyaltyTransactionRepository: Repository<LoyaltyTransaction>,
    @InjectRepository(LoyaltyReward)
    private loyaltyRewardRepository: Repository<LoyaltyReward>,
  ) {}

  async createAccount(userId: string): Promise<LoyaltyAccount> {
    const referralCode = this.generateReferralCode();
    
    const account = this.loyaltyAccountRepository.create({
      userId,
      referralCode,
    });

    return this.loyaltyAccountRepository.save(account);
  }

  async getAccount(userId: string): Promise<LoyaltyAccount> {
    let account = await this.loyaltyAccountRepository.findOne({
      where: { userId },
      relations: ['transactions'],
    });

    if (!account) {
      account = await this.createAccount(userId);
    }

    return account;
  }

  async addPoints(
    userId: string,
    points: number,
    type: LoyaltyTransactionType,
    description: string,
    referenceId?: string,
  ): Promise<LoyaltyAccount> {
    const account = await this.getAccount(userId);
    
    account.currentPoints += points;
    account.lifetimePoints += points;
    
    // Check for tier upgrade
    account.currentTier = this.calculateTier(account.lifetimePoints);
    
    await this.loyaltyAccountRepository.save(account);

    // Create transaction record
    await this.loyaltyTransactionRepository.save({
      loyaltyAccountId: account.id,
      points,
      type,
      description,
      referenceId,
    });

    return account;
  }

  async redeemPoints(userId: string, points: number, description: string): Promise<LoyaltyAccount> {
    const account = await this.getAccount(userId);
    
    if (account.currentPoints < points) {
      throw new BadRequestException('Insufficient points');
    }

    account.currentPoints -= points;
    await this.loyaltyAccountRepository.save(account);

    // Create transaction record
    await this.loyaltyTransactionRepository.save({
      loyaltyAccountId: account.id,
      points: -points,
      type: LoyaltyTransactionType.REDEEMED,
      description,
    });

    return account;
  }

  async processReferral(referralCode: string, newUserId: string): Promise<void> {
    const referrerAccount = await this.loyaltyAccountRepository.findOne({
      where: { referralCode },
    });

    if (!referrerAccount) {
      throw new NotFoundException('Invalid referral code');
    }

    // Add points to referrer
    await this.addPoints(
      referrerAccount.userId,
      100, // Referral bonus points
      LoyaltyTransactionType.REFERRAL,
      'Referral bonus',
      newUserId,
    );

    // Update referral count
    referrerAccount.totalReferrals += 1;
    await this.loyaltyAccountRepository.save(referrerAccount);
  }

  async getRewards(): Promise<LoyaltyReward[]> {
    return this.loyaltyRewardRepository.find({
      where: { isActive: true },
      order: { pointsCost: 'ASC' },
    });
  }

  async getLoyaltyData(userId: string) {
    const account = await this.getAccount(userId);
    const rewards = await this.getRewards();
    const transactions = await this.loyaltyTransactionRepository.find({
      where: { loyaltyAccountId: account.id },
      order: { createdAt: 'DESC' },
      take: 10,
    });

    const tierInfo = this.getTierInfo(account.currentTier);

    return {
      userId: account.userId,
      currentPoints: account.currentPoints,
      currentTier: account.currentTier,
      currentTierPoints: tierInfo.minPoints,
      nextTierPoints: tierInfo.nextTierPoints,
      referralCode: account.referralCode,
      totalReferrals: account.totalReferrals,
      transactions,
      availableRewards: rewards,
    };
  }

  private generateReferralCode(): string {
    return Math.random().toString(36).substring(2, 8).toUpperCase();
  }

  private calculateTier(lifetimePoints: number): LoyaltyTier {
    if (lifetimePoints >= 1000) return LoyaltyTier.PLATINUM;
    if (lifetimePoints >= 500) return LoyaltyTier.GOLD;
    if (lifetimePoints >= 100) return LoyaltyTier.SILVER;
    return LoyaltyTier.BRONZE;
  }

  private getTierInfo(tier: LoyaltyTier) {
    switch (tier) {
      case LoyaltyTier.BRONZE:
        return { minPoints: 0, nextTierPoints: 100 };
      case LoyaltyTier.SILVER:
        return { minPoints: 100, nextTierPoints: 500 };
      case LoyaltyTier.GOLD:
        return { minPoints: 500, nextTierPoints: 1000 };
      case LoyaltyTier.PLATINUM:
        return { minPoints: 1000, nextTierPoints: 1000 };
    }
  }
}