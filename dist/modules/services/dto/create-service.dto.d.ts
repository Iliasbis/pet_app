import { ServiceType } from '../entities/service.entity';
export declare class CreateServiceDto {
    name: string;
    description?: string;
    type: ServiceType;
    smallPetPrice: number;
    mediumPetPrice: number;
    largePetPrice: number;
    cratePrice?: number;
    medicationPrice?: number;
    waitReturnHourlyPrice?: number;
    specialTimePrice?: number;
    roundTripMultiplier?: number;
    isActive?: boolean;
}
