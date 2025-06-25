import { BookingType } from '../entities/booking.entity';
import { PetSize } from '../../pets/entities/pet.entity';
export declare class CreateBookingDto {
    pickupAddress: string;
    dropOffAddress: string;
    pickupDate: Date;
    pickupTime: string;
    dropOffDate?: Date;
    dropOffTime?: string;
    type: BookingType;
    petId: string;
    serviceId: string;
    petSize: PetSize;
    needsCrate?: boolean;
    needsMedication?: boolean;
    waitReturnHours?: number;
    isSpecialTime?: boolean;
    specialInstructions?: string;
}
