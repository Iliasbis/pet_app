"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.LoyaltyService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const loyalty_account_entity_1 = require("./entities/loyalty-account.entity");
const loyalty_transaction_entity_1 = require("./entities/loyalty-transaction.entity");
const loyalty_reward_entity_1 = require("./entities/loyalty-reward.entity");
let LoyaltyService = class LoyaltyService {
    constructor(loyaltyAccountRepository, loyaltyTransactionRepository, loyaltyRewardRepository) {
        this.loyaltyAccountRepository = loyaltyAccountRepository;
        this.loyaltyTransactionRepository = loyaltyTransactionRepository;
        this.loyaltyRewardRepository = loyaltyRewardRepository;
    }
    async createAccount(userId) {
        const referralCode = this.generateReferralCode();
        const account = this.loyaltyAccountRepository.create({
            userId,
            referralCode,
        });
        return this.loyaltyAccountRepository.save(account);
    }
    async getAccount(userId) {
        let account = await this.loyaltyAccountRepository.findOne({
            where: { userId },
            relations: ['transactions'],
        });
        if (!account) {
            account = await this.createAccount(userId);
        }
        return account;
    }
    async addPoints(userId, points, type, description, referenceId) {
        const account = await this.getAccount(userId);
        account.currentPoints += points;
        account.lifetimePoints += points;
        account.currentTier = this.calculateTier(account.lifetimePoints);
        await this.loyaltyAccountRepository.save(account);
        await this.loyaltyTransactionRepository.save({
            loyaltyAccountId: account.id,
            points,
            type,
            description,
            referenceId,
        });
        return account;
    }
    async redeemPoints(userId, points, description) {
        const account = await this.getAccount(userId);
        if (account.currentPoints < points) {
            throw new common_1.BadRequestException('Insufficient points');
        }
        account.currentPoints -= points;
        await this.loyaltyAccountRepository.save(account);
        await this.loyaltyTransactionRepository.save({
            loyaltyAccountId: account.id,
            points: -points,
            type: loyalty_transaction_entity_1.LoyaltyTransactionType.REDEEMED,
            description,
        });
        return account;
    }
    async processReferral(referralCode, newUserId) {
        const referrerAccount = await this.loyaltyAccountRepository.findOne({
            where: { referralCode },
        });
        if (!referrerAccount) {
            throw new common_1.NotFoundException('Invalid referral code');
        }
        await this.addPoints(referrerAccount.userId, 100, loyalty_transaction_entity_1.LoyaltyTransactionType.REFERRAL, 'Referral bonus', newUserId);
        referrerAccount.totalReferrals += 1;
        await this.loyaltyAccountRepository.save(referrerAccount);
    }
    async getRewards() {
        return this.loyaltyRewardRepository.find({
            where: { isActive: true },
            order: { pointsCost: 'ASC' },
        });
    }
    async getLoyaltyData(userId) {
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
    generateReferralCode() {
        return Math.random().toString(36).substring(2, 8).toUpperCase();
    }
    calculateTier(lifetimePoints) {
        if (lifetimePoints >= 1000)
            return loyalty_account_entity_1.LoyaltyTier.PLATINUM;
        if (lifetimePoints >= 500)
            return loyalty_account_entity_1.LoyaltyTier.GOLD;
        if (lifetimePoints >= 100)
            return loyalty_account_entity_1.LoyaltyTier.SILVER;
        return loyalty_account_entity_1.LoyaltyTier.BRONZE;
    }
    getTierInfo(tier) {
        switch (tier) {
            case loyalty_account_entity_1.LoyaltyTier.BRONZE:
                return { minPoints: 0, nextTierPoints: 100 };
            case loyalty_account_entity_1.LoyaltyTier.SILVER:
                return { minPoints: 100, nextTierPoints: 500 };
            case loyalty_account_entity_1.LoyaltyTier.GOLD:
                return { minPoints: 500, nextTierPoints: 1000 };
            case loyalty_account_entity_1.LoyaltyTier.PLATINUM:
                return { minPoints: 1000, nextTierPoints: 1000 };
        }
    }
};
exports.LoyaltyService = LoyaltyService;
exports.LoyaltyService = LoyaltyService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(loyalty_account_entity_1.LoyaltyAccount)),
    __param(1, (0, typeorm_1.InjectRepository)(loyalty_transaction_entity_1.LoyaltyTransaction)),
    __param(2, (0, typeorm_1.InjectRepository)(loyalty_reward_entity_1.LoyaltyReward)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository])
], LoyaltyService);
//# sourceMappingURL=loyalty.service.js.map