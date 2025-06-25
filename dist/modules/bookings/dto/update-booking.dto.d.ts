import { CreateBookingDto } from './create-booking.dto';
import { BookingStatus } from '../entities/booking.entity';
declare const UpdateBookingDto_base: import("@nestjs/common").Type<Partial<CreateBookingDto>>;
export declare class UpdateBookingDto extends UpdateBookingDto_base {
    totalPrice?: number;
    adminNotes?: string;
    assignedDriverId?: string;
    status?: BookingStatus;
}
export {};
