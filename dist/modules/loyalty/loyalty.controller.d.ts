import { LoyaltyService } from './loyalty.service';
export declare class LoyaltyController {
    private readonly loyaltyService;
    constructor(loyaltyService: LoyaltyService);
    getLoyaltyData(req: any): Promise<{
        userId: string;
        currentPoints: number;
        currentTier: import("./entities/loyalty-account.entity").LoyaltyTier;
        currentTierPoints: number;
        nextTierPoints: number;
        referralCode: string;
        totalReferrals: number;
        transactions: import("./entities/loyalty-transaction.entity").LoyaltyTransaction[];
        availableRewards: import("./entities/loyalty-reward.entity").LoyaltyReward[];
    }>;
    getRewards(): Promise<import("./entities/loyalty-reward.entity").LoyaltyReward[]>;
    redeemPoints(req: any, body: {
        points: number;
        description: string;
    }): Promise<import("./entities/loyalty-account.entity").LoyaltyAccount>;
    processReferral(req: any, body: {
        referralCode: string;
    }): Promise<void>;
}
