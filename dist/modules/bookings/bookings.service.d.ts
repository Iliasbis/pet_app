import { Repository } from 'typeorm';
import { Booking, BookingStatus } from './entities/booking.entity';
import { CreateBookingDto } from './dto/create-booking.dto';
import { UpdateBookingDto } from './dto/update-booking.dto';
import { ServicesService } from '../services/services.service';
export declare class BookingsService {
    private bookingsRepository;
    private servicesService;
    constructor(bookingsRepository: Repository<Booking>, servicesService: ServicesService);
    create(createBookingDto: CreateBookingDto, userId: string): Promise<Booking>;
    findAll(): Promise<Booking[]>;
    findByUser(userId: string): Promise<Booking[]>;
    findOne(id: string, userId?: string): Promise<Booking>;
    update(id: string, updateBookingDto: UpdateBookingDto, userId?: string): Promise<Booking>;
    updateStatus(id: string, status: BookingStatus): Promise<Booking>;
    remove(id: string, userId?: string): Promise<void>;
    getBookingStats(): Promise<{
        totalBookings: number;
        pendingBookings: number;
        confirmedBookings: number;
        completedBookings: number;
    }>;
}
