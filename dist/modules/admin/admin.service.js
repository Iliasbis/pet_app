"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AdminService = void 0;
const common_1 = require("@nestjs/common");
const users_service_1 = require("../users/users.service");
const bookings_service_1 = require("../bookings/bookings.service");
const payments_service_1 = require("../payments/payments.service");
const services_service_1 = require("../services/services.service");
let AdminService = class AdminService {
    constructor(usersService, bookingsService, paymentsService, servicesService) {
        this.usersService = usersService;
        this.bookingsService = bookingsService;
        this.paymentsService = paymentsService;
        this.servicesService = servicesService;
    }
    async getDashboardStats() {
        const totalUsers = await this.usersService.findAll();
        const bookingStats = await this.bookingsService.getBookingStats();
        const recentBookings = await this.bookingsService.findAll();
        const payments = await this.paymentsService.findAll();
        const totalRevenue = payments
            .filter(payment => payment.status === 'completed')
            .reduce((sum, payment) => sum + Number(payment.amount), 0);
        return {
            totalUsers: totalUsers.length,
            totalRevenue: Math.round(totalRevenue * 100) / 100,
            ...bookingStats,
            recentBookings: recentBookings.slice(0, 10),
        };
    }
    async getUsers() {
        return this.usersService.findAll();
    }
    async getBookings() {
        return this.bookingsService.findAll();
    }
    async getPayments() {
        return this.paymentsService.findAll();
    }
    async getServices() {
        return this.servicesService.findAll();
    }
};
exports.AdminService = AdminService;
exports.AdminService = AdminService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [users_service_1.UsersService,
        bookings_service_1.BookingsService,
        payments_service_1.PaymentsService,
        services_service_1.ServicesService])
], AdminService);
//# sourceMappingURL=admin.service.js.map