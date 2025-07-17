import { LoyaltyAccount } from './loyalty-account.entity';
export declare enum LoyaltyTransactionType {
    EARNED = "earned",
    REDEEMED = "redeemed",
    REFERRAL = "referral",
    BONUS = "bonus",
    EXPIRED = "expired"
}
export declare class LoyaltyTransaction {
    id: string;
    points: number;
    type: LoyaltyTransactionType;
    description: string;
    referenceId: string;
    createdAt: Date;
    loyaltyAccount: LoyaltyAccount;
    loyaltyAccountId: string;
}
