import { Pet } from '../../pets/entities/pet.entity';
import { Booking } from '../../bookings/entities/booking.entity';
export declare enum UserRole {
    USER = "user",
    ADMIN = "admin",
    DRIVER = "driver"
}
export declare class User {
    id: string;
    email: string;
    password: string;
    firstName: string;
    lastName: string;
    phone: string;
    address: string;
    role: UserRole;
    isActive: boolean;
    createdAt: Date;
    updatedAt: Date;
    pets: Pet[];
    bookings: Booking[];
}
