import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { DriversService } from './drivers.service';
import { CreateDriverDto } from './dto/create-driver.dto';
import { UpdateDriverDto } from './dto/update-driver.dto';
import { UpdateDriverStatusDto } from './dto/update-driver-status.dto';
import { UpdateLocationDto } from './dto/update-location.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Drivers')
@Controller('drivers')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class DriversController {
  constructor(private readonly driversService: DriversService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new driver (Admin only)' })
  @ApiResponse({ status: 201, description: 'Driver created successfully' })
  create(@Body() createDriverDto: CreateDriverDto) {
    return this.driversService.create(createDriverDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all drivers (Admin only)' })
  @ApiResponse({ status: 200, description: 'Drivers retrieved successfully' })
  findAll() {
    return this.driversService.findAll();
  }

  @Get('available')
  @ApiOperation({ summary: 'Get available drivers' })
  @ApiResponse({ status: 200, description: 'Available drivers retrieved successfully' })
  findAvailable() {
    return this.driversService.findAvailableDrivers();
  }

  @Get('me')
  @ApiOperation({ summary: 'Get current driver profile' })
  @ApiResponse({ status: 200, description: 'Driver profile retrieved successfully' })
  getProfile(@Request() req) {
    return this.driversService.findById(req.user.id);
  }

  @Get('me/stats')
  @ApiOperation({ summary: 'Get driver statistics' })
  @ApiResponse({ status: 200, description: 'Driver stats retrieved successfully' })
  getStats(@Request() req) {
    return this.driversService.getDriverStats(req.user.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get driver by ID' })
  @ApiResponse({ status: 200, description: 'Driver retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Driver not found' })
  findOne(@Param('id') id: string) {
    return this.driversService.findById(id);
  }

  @Patch('me')
  @ApiOperation({ summary: 'Update current driver profile' })
  @ApiResponse({ status: 200, description: 'Driver profile updated successfully' })
  updateProfile(@Request() req, @Body() updateDriverDto: UpdateDriverDto) {
    return this.driversService.update(req.user.id, updateDriverDto);
  }

  @Patch('me/status')
  @ApiOperation({ summary: 'Update driver status' })
  @ApiResponse({ status: 200, description: 'Driver status updated successfully' })
  updateStatus(@Request() req, @Body() updateStatusDto: UpdateDriverStatusDto) {
    return this.driversService.updateStatus(req.user.id, updateStatusDto.status);
  }

  @Patch('me/location')
  @ApiOperation({ summary: 'Update driver location' })
  @ApiResponse({ status: 200, description: 'Driver location updated successfully' })
  updateLocation(@Request() req, @Body() updateLocationDto: UpdateLocationDto) {
    return this.driversService.updateLocation(
      req.user.id,
      updateLocationDto.latitude,
      updateLocationDto.longitude,
    );
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update driver by ID (Admin only)' })
  @ApiResponse({ status: 200, description: 'Driver updated successfully' })
  @ApiResponse({ status: 404, description: 'Driver not found' })
  update(@Param('id') id: string, @Body() updateDriverDto: UpdateDriverDto) {
    return this.driversService.update(id, updateDriverDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete driver by ID (Admin only)' })
  @ApiResponse({ status: 200, description: 'Driver deleted successfully' })
  @ApiResponse({ status: 404, description: 'Driver not found' })
  remove(@Param('id') id: string) {
    return this.driversService.remove(id);
  }
}