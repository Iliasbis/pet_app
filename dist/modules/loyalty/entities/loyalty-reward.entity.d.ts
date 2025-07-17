export declare enum RewardType {
    DISCOUNT = "discount",
    FREE_RIDE = "free_ride",
    UPGRADE = "upgrade",
    MERCHANDISE = "merchandise"
}
export declare class LoyaltyReward {
    id: string;
    name: string;
    description: string;
    pointsCost: number;
    type: RewardType;
    discountAmount: number;
    discountType: string;
    isActive: boolean;
    createdAt: Date;
    updatedAt: Date;
}
