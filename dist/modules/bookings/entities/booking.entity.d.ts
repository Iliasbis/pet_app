import { User } from '../../users/entities/user.entity';
import { Pet } from '../../pets/entities/pet.entity';
import { Service } from '../../services/entities/service.entity';
import { Payment } from '../../payments/entities/payment.entity';
export declare enum BookingStatus {
    PENDING = "pending",
    CONFIRMED = "confirmed",
    IN_PROGRESS = "in_progress",
    COMPLETED = "completed",
    CANCELLED = "cancelled"
}
export declare enum BookingType {
    ONE_WAY = "one_way",
    ROUND_TRIP = "round_trip"
}
export declare class Booking {
    id: string;
    pickupAddress: string;
    dropOffAddress: string;
    pickupDate: Date;
    pickupTime: string;
    dropOffDate: Date;
    dropOffTime: string;
    type: BookingType;
    status: BookingStatus;
    totalPrice: number;
    needsCrate: boolean;
    needsMedication: boolean;
    waitReturnHours: number;
    isSpecialTime: boolean;
    specialInstructions: string;
    adminNotes: string;
    assignedDriverId: string;
    createdAt: Date;
    updatedAt: Date;
    user: User;
    userId: string;
    pet: Pet;
    petId: string;
    service: Service;
    serviceId: string;
    payment: Payment;
}
