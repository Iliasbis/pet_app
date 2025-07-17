import { Repository } from 'typeorm';
import { LoyaltyAccount, LoyaltyTier } from './entities/loyalty-account.entity';
import { LoyaltyTransaction, LoyaltyTransactionType } from './entities/loyalty-transaction.entity';
import { LoyaltyReward } from './entities/loyalty-reward.entity';
export declare class LoyaltyService {
    private loyaltyAccountRepository;
    private loyaltyTransactionRepository;
    private loyaltyRewardRepository;
    constructor(loyaltyAccountRepository: Repository<LoyaltyAccount>, loyaltyTransactionRepository: Repository<LoyaltyTransaction>, loyaltyRewardRepository: Repository<LoyaltyReward>);
    createAccount(userId: string): Promise<LoyaltyAccount>;
    getAccount(userId: string): Promise<LoyaltyAccount>;
    addPoints(userId: string, points: number, type: LoyaltyTransactionType, description: string, referenceId?: string): Promise<LoyaltyAccount>;
    redeemPoints(userId: string, points: number, description: string): Promise<LoyaltyAccount>;
    processReferral(referralCode: string, newUserId: string): Promise<void>;
    getRewards(): Promise<LoyaltyReward[]>;
    getLoyaltyData(userId: string): Promise<{
        userId: string;
        currentPoints: number;
        currentTier: LoyaltyTier;
        currentTierPoints: number;
        nextTierPoints: number;
        referralCode: string;
        totalReferrals: number;
        transactions: LoyaltyTransaction[];
        availableRewards: LoyaltyReward[];
    }>;
    private generateReferralCode;
    private calculateTier;
    private getTierInfo;
}
