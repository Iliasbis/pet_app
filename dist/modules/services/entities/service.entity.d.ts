export declare enum ServiceType {
    LOCAL = "local",
    STANDARD = "standard",
    LONG = "long",
    EXTENDED = "extended"
}
export declare class Service {
    id: string;
    name: string;
    description: string;
    type: ServiceType;
    smallPetPrice: number;
    mediumPetPrice: number;
    largePetPrice: number;
    cratePrice: number;
    medicationPrice: number;
    waitReturnHourlyPrice: number;
    specialTimePrice: number;
    roundTripMultiplier: number;
    isActive: boolean;
    createdAt: Date;
    updatedAt: Date;
}
