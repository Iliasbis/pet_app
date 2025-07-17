import { UsersService } from '../users/users.service';
import { BookingsService } from '../bookings/bookings.service';
import { PaymentsService } from '../payments/payments.service';
import { ServicesService } from '../services/services.service';
export declare class AdminService {
    private usersService;
    private bookingsService;
    private paymentsService;
    private servicesService;
    constructor(usersService: UsersService, bookingsService: BookingsService, paymentsService: PaymentsService, servicesService: ServicesService);
    getDashboardStats(): Promise<{
        recentBookings: import("../bookings/entities/booking.entity").Booking[];
        totalBookings: number;
        pendingBookings: number;
        confirmedBookings: number;
        completedBookings: number;
        totalUsers: number;
        totalRevenue: number;
    }>;
    getUsers(): Promise<import("../users/entities/user.entity").User[]>;
    getBookings(): Promise<import("../bookings/entities/booking.entity").Booking[]>;
    getPayments(): Promise<import("../payments/entities/payment.entity").Payment[]>;
    getServices(): Promise<import("../services/entities/service.entity").Service[]>;
}
