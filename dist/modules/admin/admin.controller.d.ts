import { AdminService } from './admin.service';
export declare class AdminController {
    private readonly adminService;
    constructor(adminService: AdminService);
    getDashboard(req: any): Promise<{
        recentBookings: import("../bookings/entities/booking.entity").Booking[];
        totalBookings: number;
        pendingBookings: number;
        confirmedBookings: number;
        completedBookings: number;
        totalUsers: number;
        totalRevenue: number;
    }>;
    getUsers(req: any): Promise<import("../users/entities/user.entity").User[]>;
    getBookings(req: any): Promise<import("../bookings/entities/booking.entity").Booking[]>;
    getPayments(req: any): Promise<import("../payments/entities/payment.entity").Payment[]>;
    getServices(req: any): Promise<import("../services/entities/service.entity").Service[]>;
}
