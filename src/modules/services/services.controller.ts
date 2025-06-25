import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { ServicesService } from './services.service';
import { CreateServiceDto } from './dto/create-service.dto';
import { UpdateServiceDto } from './dto/update-service.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { PetSize } from '../pets/entities/pet.entity';

@ApiTags('Services')
@Controller('services')
export class ServicesController {
  constructor(private readonly servicesService: ServicesService) {}

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Create a new service (Admin only)' })
  @ApiResponse({ status: 201, description: 'Service created successfully' })
  create(@Body() createServiceDto: CreateServiceDto) {
    return this.servicesService.create(createServiceDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all active services' })
  @ApiResponse({ status: 200, description: 'Services retrieved successfully' })
  findAll() {
    return this.servicesService.findAll();
  }

  @Get('calculate-price/:id')
  @ApiOperation({ summary: 'Calculate price for a service' })
  @ApiQuery({ name: 'petSize', enum: PetSize })
  @ApiQuery({ name: 'isRoundTrip', type: 'boolean', required: false })
  @ApiQuery({ name: 'needsCrate', type: 'boolean', required: false })
  @ApiQuery({ name: 'needsMedication', type: 'boolean', required: false })
  @ApiQuery({ name: 'waitReturnHours', type: 'number', required: false })
  @ApiQuery({ name: 'isSpecialTime', type: 'boolean', required: false })
  async calculatePrice(
    @Param('id') id: string,
    @Query('petSize') petSize: PetSize,
    @Query('isRoundTrip') isRoundTrip: string = 'false',
    @Query('needsCrate') needsCrate: string = 'false',
    @Query('needsMedication') needsMedication: string = 'false',
    @Query('waitReturnHours') waitReturnHours: string = '0',
    @Query('isSpecialTime') isSpecialTime: string = 'false',
  ) {
    const service = await this.servicesService.findOne(id);
    const price = this.servicesService.calculatePrice(
      service,
      petSize,
      isRoundTrip === 'true',
      needsCrate === 'true',
      needsMedication === 'true',
      parseInt(waitReturnHours),
      isSpecialTime === 'true',
    );

    return { price, service: service.name };
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get service by ID' })
  @ApiResponse({ status: 200, description: 'Service retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Service not found' })
  findOne(@Param('id') id: string) {
    return this.servicesService.findOne(id);
  }

  @Patch(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Update service by ID (Admin only)' })
  @ApiResponse({ status: 200, description: 'Service updated successfully' })
  @ApiResponse({ status: 404, description: 'Service not found' })
  update(@Param('id') id: string, @Body() updateServiceDto: UpdateServiceDto) {
    return this.servicesService.update(id, updateServiceDto);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Delete service by ID (Admin only)' })
  @ApiResponse({ status: 200, description: 'Service deleted successfully' })
  @ApiResponse({ status: 404, description: 'Service not found' })
  remove(@Param('id') id: string) {
    return this.servicesService.remove(id);
  }
}