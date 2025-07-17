import { Booking } from '../../bookings/entities/booking.entity';
export declare enum DriverStatus {
    OFFLINE = "offline",
    AVAILABLE = "available",
    BUSY = "busy",
    ON_RIDE = "on_ride"
}
export declare class Driver {
    id: string;
    email: string;
    password: string;
    firstName: string;
    lastName: string;
    phone: string;
    address: string;
    licenseNumber: string;
    vehicleInfo: string;
    status: DriverStatus;
    currentLatitude: number;
    currentLongitude: number;
    rating: number;
    totalRides: number;
    totalEarnings: number;
    isActive: boolean;
    isVerified: boolean;
    createdAt: Date;
    updatedAt: Date;
    bookings: Booking[];
}
