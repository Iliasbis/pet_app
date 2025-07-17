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
exports.DriversService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const driver_entity_1 = require("./entities/driver.entity");
const bcrypt = require("bcryptjs");
let DriversService = class DriversService {
    constructor(driversRepository) {
        this.driversRepository = driversRepository;
    }
    async create(createDriverDto) {
        const existingDriver = await this.driversRepository.findOne({
            where: { email: createDriverDto.email },
        });
        if (existingDriver) {
            throw new common_1.ConflictException('Driver already exists with this email');
        }
        const hashedPassword = await bcrypt.hash(createDriverDto.password, 12);
        const driver = this.driversRepository.create({
            ...createDriverDto,
            password: hashedPassword,
        });
        return this.driversRepository.save(driver);
    }
    async findAll() {
        return this.driversRepository.find({
            relations: ['bookings'],
            order: { createdAt: 'DESC' },
        });
    }
    async findById(id) {
        const driver = await this.driversRepository.findOne({
            where: { id },
            relations: ['bookings'],
        });
        if (!driver) {
            throw new common_1.NotFoundException(`Driver with ID ${id} not found`);
        }
        return driver;
    }
    async findByEmail(email) {
        return this.driversRepository.findOne({ where: { email } });
    }
    async findAvailableDrivers() {
        return this.driversRepository.find({
            where: {
                status: driver_entity_1.DriverStatus.AVAILABLE,
                isActive: true,
                isVerified: true,
            },
        });
    }
    async update(id, updateDriverDto) {
        const driver = await this.findById(id);
        if (updateDriverDto.password) {
            updateDriverDto.password = await bcrypt.hash(updateDriverDto.password, 12);
        }
        Object.assign(driver, updateDriverDto);
        return this.driversRepository.save(driver);
    }
    async updateStatus(id, status) {
        const driver = await this.findById(id);
        driver.status = status;
        return this.driversRepository.save(driver);
    }
    async updateLocation(id, latitude, longitude) {
        const driver = await this.findById(id);
        driver.currentLatitude = latitude;
        driver.currentLongitude = longitude;
        return this.driversRepository.save(driver);
    }
    async updateEarnings(id, amount) {
        const driver = await this.findById(id);
        driver.totalEarnings = Number(driver.totalEarnings) + amount;
        driver.totalRides += 1;
        return this.driversRepository.save(driver);
    }
    async remove(id) {
        const driver = await this.findById(id);
        await this.driversRepository.remove(driver);
    }
    async getDriverStats(id) {
        const driver = await this.findById(id);
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const thisWeek = new Date();
        thisWeek.setDate(thisWeek.getDate() - 7);
        const thisMonth = new Date();
        thisMonth.setDate(1);
        return {
            totalRides: driver.totalRides,
            totalEarnings: driver.totalEarnings,
            rating: driver.rating,
            status: driver.status,
        };
    }
};
exports.DriversService = DriversService;
exports.DriversService = DriversService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(driver_entity_1.Driver)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], DriversService);
//# sourceMappingURL=drivers.service.js.map