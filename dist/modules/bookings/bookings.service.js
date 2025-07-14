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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.BookingsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const booking_entity_1 = require("./entities/booking.entity");
const services_service_1 = require("../services/services.service");
let BookingsService = class BookingsService {
    constructor(bookingsRepository, servicesService) {
        this.bookingsRepository = bookingsRepository;
        this.servicesService = servicesService;
    }
    async create(createBookingDto, userId) {
        const service = await this.servicesService.findOne(createBookingDto.serviceId);
        const totalPrice = this.servicesService.calculatePrice(service, createBookingDto.petSize, createBookingDto.type === 'round_trip', createBookingDto.needsCrate, createBookingDto.needsMedication, createBookingDto.waitReturnHours, createBookingDto.isSpecialTime);
        const booking = this.bookingsRepository.create({
            ...createBookingDto,
            userId,
            totalPrice,
        });
        return this.bookingsRepository.save(booking);
    }
    async findAll() {
        return this.bookingsRepository.find({
            relations: ['user', 'pet', 'service', 'payment'],
            order: { createdAt: 'DESC' },
        });
    }
    async findByUser(userId) {
        return this.bookingsRepository.find({
            where: { userId },
            relations: ['user', 'pet', 'service', 'payment'],
            order: { createdAt: 'DESC' },
        });
    }
    async findOne(id, userId) {
        const booking = await this.bookingsRepository.findOne({
            where: { id },
            relations: ['user', 'pet', 'service', 'payment'],
        });
        if (!booking) {
            throw new common_1.NotFoundException(`Booking with ID ${id} not found`);
        }
        if (userId && booking.userId !== userId) {
            throw new common_1.ForbiddenException('You can only access your own bookings');
        }
        return booking;
    }
    async update(id, updateBookingDto, userId) {
        const booking = await this.findOne(id, userId);
        if (updateBookingDto.serviceId ||
            updateBookingDto.needsCrate !== undefined ||
            updateBookingDto.needsMedication !== undefined ||
            updateBookingDto.waitReturnHours !== undefined ||
            updateBookingDto.isSpecialTime !== undefined ||
            updateBookingDto.type) {
            const serviceId = updateBookingDto.serviceId || booking.serviceId;
            const service = await this.servicesService.findOne(serviceId);
            const totalPrice = this.servicesService.calculatePrice(service, booking.pet.size, (updateBookingDto.type || booking.type) === 'round_trip', updateBookingDto.needsCrate ?? booking.needsCrate, updateBookingDto.needsMedication ?? booking.needsMedication, updateBookingDto.waitReturnHours ?? booking.waitReturnHours, updateBookingDto.isSpecialTime ?? booking.isSpecialTime);
            updateBookingDto.totalPrice = totalPrice;
        }
        Object.assign(booking, updateBookingDto);
        return this.bookingsRepository.save(booking);
    }
    async updateStatus(id, status) {
        const booking = await this.findOne(id);
        booking.status = status;
        return this.bookingsRepository.save(booking);
    }
    async remove(id, userId) {
        const booking = await this.findOne(id, userId);
        await this.bookingsRepository.remove(booking);
    }
    async getBookingStats() {
        const totalBookings = await this.bookingsRepository.count();
        const pendingBookings = await this.bookingsRepository.count({ where: { status: booking_entity_1.BookingStatus.PENDING } });
        const confirmedBookings = await this.bookingsRepository.count({ where: { status: booking_entity_1.BookingStatus.CONFIRMED } });
        const completedBookings = await this.bookingsRepository.count({ where: { status: booking_entity_1.BookingStatus.COMPLETED } });
        return {
            totalBookings,
            pendingBookings,
            confirmedBookings,
            completedBookings,
        };
    }
};
exports.BookingsService = BookingsService;
exports.BookingsService = BookingsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(booking_entity_1.Booking)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        services_service_1.ServicesService])
], BookingsService);
//# sourceMappingURL=bookings.service.js.map