import { Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { BookingsService } from '../bookings/bookings.service';
import { PaymentsService } from '../payments/payments.service';
import { ServicesService } from '../services/services.service';

@Injectable()
export class AdminService {
  constructor(
    private usersService: UsersService,
    private bookingsService: BookingsService,
    private paymentsService: PaymentsService,
    private servicesService: ServicesService,
  ) {}

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
      recentBookings: recentBookings.slice(0, 10), // Last 10 bookings
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
}