import { CreateDriverDto } from './create-driver.dto';
declare const UpdateDriverDto_base: import("@nestjs/common").Type<Partial<CreateDriverDto>>;
export declare class UpdateDriverDto extends UpdateDriverDto_base {
    currentLatitude?: number;
    currentLongitude?: number;
    rating?: number;
    totalRides?: number;
    totalEarnings?: number;
    isActive?: boolean;
    isVerified?: boolean;
}
export {};
