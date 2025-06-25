import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Booking, BookingStatus } from './entities/booking.entity';
import { CreateBookingDto } from './dto/create-booking.dto';
import { UpdateBookingDto } from './dto/update-booking.dto';
import { ServicesService } from '../services/services.service';

@Injectable()
export class BookingsService {
  constructor(
    @InjectRepository(Booking)
    private bookingsRepository: Repository<Booking>,
    private servicesService: ServicesService,
  ) {}

  async create(createBookingDto: CreateBookingDto, userId: string): Promise<Booking> {
    // Calculate total price
    const service = await this.servicesService.findOne(createBookingDto.serviceId);
    const totalPrice = this.servicesService.calculatePrice(
      service,
      createBookingDto.petSize,
      createBookingDto.type === 'round_trip',
      createBookingDto.needsCrate,
      createBookingDto.needsMedication,
      createBookingDto.waitReturnHours,
      createBookingDto.isSpecialTime,
    );

    const booking = this.bookingsRepository.create({
      ...createBookingDto,
      userId,
      totalPrice,
    });

    return this.bookingsRepository.save(booking);
  }

  async findAll(): Promise<Booking[]> {
    return this.bookingsRepository.find({
      relations: ['user', 'pet', 'service', 'payment'],
      order: { createdAt: 'DESC' },
    });
  }

  async findByUser(userId: string): Promise<Booking[]> {
    return this.bookingsRepository.find({
      where: { userId },
      relations: ['user', 'pet', 'service', 'payment'],
      order: { createdAt: 'DESC' },
    });
  }

  async findOne(id: string, userId?: string): Promise<Booking> {
    const booking = await this.bookingsRepository.findOne({
      where: { id },
      relations: ['user', 'pet', 'service', 'payment'],
    });

    if (!booking) {
      throw new NotFoundException(`Booking with ID ${id} not found`);
    }

    // Check if user has permission to view this booking
    if (userId && booking.userId !== userId) {
      throw new ForbiddenException('You can only access your own bookings');
    }

    return booking;
  }

  async update(id: string, updateBookingDto: UpdateBookingDto, userId?: string): Promise<Booking> {
    const booking = await this.findOne(id, userId);

    // Recalculate price if service-related fields changed
    if (updateBookingDto.serviceId || 
        updateBookingDto.needsCrate !== undefined ||
        updateBookingDto.needsMedication !== undefined ||
        updateBookingDto.waitReturnHours !== undefined ||
        updateBookingDto.isSpecialTime !== undefined ||
        updateBookingDto.type) {
      
      const serviceId = updateBookingDto.serviceId || booking.serviceId;
      const service = await this.servicesService.findOne(serviceId);
      
      const totalPrice = this.servicesService.calculatePrice(
        service,
        booking.pet.size,
        (updateBookingDto.type || booking.type) === 'round_trip',
        updateBookingDto.needsCrate ?? booking.needsCrate,
        updateBookingDto.needsMedication ?? booking.needsMedication,
        updateBookingDto.waitReturnHours ?? booking.waitReturnHours,
        updateBookingDto.isSpecialTime ?? booking.isSpecialTime,
      );
      
      updateBookingDto.totalPrice = totalPrice;
    }

    Object.assign(booking, updateBookingDto);
    return this.bookingsRepository.save(booking);
  }

  async updateStatus(id: string, status: BookingStatus): Promise<Booking> {
    const booking = await this.findOne(id);
    booking.status = status;
    return this.bookingsRepository.save(booking);
  }

  async remove(id: string, userId?: string): Promise<void> {
    const booking = await this.findOne(id, userId);
    await this.bookingsRepository.remove(booking);
  }

  async getBookingStats() {
    const totalBookings = await this.bookingsRepository.count();
    const pendingBookings = await this.bookingsRepository.count({ where: { status: BookingStatus.PENDING } });
    const confirmedBookings = await this.bookingsRepository.count({ where: { status: BookingStatus.CONFIRMED } });
    const completedBookings = await this.bookingsRepository.count({ where: { status: BookingStatus.COMPLETED } });

    return {
      totalBookings,
      pendingBookings,
      confirmedBookings,
      completedBookings,
    };
  }
}