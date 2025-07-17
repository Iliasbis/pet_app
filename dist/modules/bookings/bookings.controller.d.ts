import { BookingsService } from './bookings.service';
import { CreateBookingDto } from './dto/create-booking.dto';
import { UpdateBookingDto } from './dto/update-booking.dto';
import { UpdateBookingStatusDto } from './dto/update-booking-status.dto';
export declare class BookingsController {
    private readonly bookingsService;
    constructor(bookingsService: BookingsService);
    create(createBookingDto: CreateBookingDto, req: any): Promise<import("./entities/booking.entity").Booking>;
    findAll(req: any): Promise<import("./entities/booking.entity").Booking[]>;
    getStats(req: any): Promise<{
        totalBookings: number;
        pendingBookings: number;
        confirmedBookings: number;
        completedBookings: number;
    }>;
    findOne(id: string, req: any): Promise<import("./entities/booking.entity").Booking>;
    update(id: string, updateBookingDto: UpdateBookingDto, req: any): Promise<import("./entities/booking.entity").Booking>;
    updateStatus(id: string, updateStatusDto: UpdateBookingStatusDto): Promise<import("./entities/booking.entity").Booking>;
    remove(id: string, req: any): Promise<void>;
}
