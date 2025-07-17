import { User } from '../../users/entities/user.entity';
import { Booking } from '../../bookings/entities/booking.entity';
export declare enum PetSize {
    SMALL = "small",
    MEDIUM = "medium",
    LARGE = "large"
}
export declare class Pet {
    id: string;
    name: string;
    breed: string;
    age: number;
    size: PetSize;
    weight: number;
    color: string;
    behaviorNotes: string;
    medicalNotes: string;
    vetName: string;
    vetPhone: string;
    vetAddress: string;
    emergencyContact: string;
    emergencyPhone: string;
    isActive: boolean;
    createdAt: Date;
    updatedAt: Date;
    owner: User;
    ownerId: string;
    bookings: Booking[];
}
