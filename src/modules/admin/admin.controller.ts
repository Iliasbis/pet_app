import { Controller, Get, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AdminService } from './admin.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Admin')
@Controller('admin')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class AdminController {
  constructor(private readonly adminService: AdminService) {}

  @Get('dashboard')
  @ApiOperation({ summary: 'Get admin dashboard statistics' })
  @ApiResponse({ status: 200, description: 'Dashboard data retrieved successfully' })
  getDashboard(@Request() req) {
    // This should have role guard for admin only
    return this.adminService.getDashboardStats();
  }

  @Get('users')
  @ApiOperation({ summary: 'Get all users (Admin only)' })
  @ApiResponse({ status: 200, description: 'Users retrieved successfully' })
  getUsers(@Request() req) {
    // This should have role guard for admin only
    return this.adminService.getUsers();
  }

  @Get('bookings')
  @ApiOperation({ summary: 'Get all bookings (Admin only)' })
  @ApiResponse({ status: 200, description: 'Bookings retrieved successfully' })
  getBookings(@Request() req) {
    // This should have role guard for admin only
    return this.adminService.getBookings();
  }

  @Get('payments')
  @ApiOperation({ summary: 'Get all payments (Admin only)' })
  @ApiResponse({ status: 200, description: 'Payments retrieved successfully' })
  getPayments(@Request() req) {
    // This should have role guard for admin only
    return this.adminService.getPayments();
  }

  @Get('services')
  @ApiOperation({ summary: 'Get all services (Admin only)' })
  @ApiResponse({ status: 200, description: 'Services retrieved successfully' })
  getServices(@Request() req) {
    // This should have role guard for admin only
    return this.adminService.getServices();
  }
}