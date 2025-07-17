import { DriverStatus } from '../entities/driver.entity';
export declare class CreateDriverDto {
    email: string;
    password: string;
    firstName: string;
    lastName: string;
    phone?: string;
    address?: string;
    licenseNumber?: string;
    vehicleInfo?: string;
    status?: DriverStatus;
}
