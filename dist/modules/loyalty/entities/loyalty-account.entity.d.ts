import { User } from '../../users/entities/user.entity';
import { LoyaltyTransaction } from './loyalty-transaction.entity';
export declare enum LoyaltyTier {
    BRONZE = "bronze",
    SILVER = "silver",
    GOLD = "gold",
    PLATINUM = "platinum"
}
export declare class LoyaltyAccount {
    id: string;
    currentPoints: number;
    currentTier: LoyaltyTier;
    lifetimePoints: number;
    referralCode: string;
    totalReferrals: number;
    createdAt: Date;
    updatedAt: Date;
    user: User;
    userId: string;
    transactions: LoyaltyTransaction[];
}
