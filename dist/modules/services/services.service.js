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
exports.ServicesService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const service_entity_1 = require("./entities/service.entity");
const pet_entity_1 = require("../pets/entities/pet.entity");
let ServicesService = class ServicesService {
    constructor(servicesRepository) {
        this.servicesRepository = servicesRepository;
    }
    async create(createServiceDto) {
        const service = this.servicesRepository.create(createServiceDto);
        return this.servicesRepository.save(service);
    }
    async findAll() {
        return this.servicesRepository.find({
            where: { isActive: true },
            order: { createdAt: 'ASC' },
        });
    }
    async findOne(id) {
        const service = await this.servicesRepository.findOne({ where: { id } });
        if (!service) {
            throw new common_1.NotFoundException(`Service with ID ${id} not found`);
        }
        return service;
    }
    async update(id, updateServiceDto) {
        const service = await this.findOne(id);
        Object.assign(service, updateServiceDto);
        return this.servicesRepository.save(service);
    }
    async remove(id) {
        const service = await this.findOne(id);
        await this.servicesRepository.remove(service);
    }
    calculatePrice(service, petSize, isRoundTrip = false, needsCrate = false, needsMedication = false, waitReturnHours = 0, isSpecialTime = false) {
        let basePrice = 0;
        switch (petSize) {
            case pet_entity_1.PetSize.SMALL:
                basePrice = Number(service.smallPetPrice);
                break;
            case pet_entity_1.PetSize.MEDIUM:
                basePrice = Number(service.mediumPetPrice);
                break;
            case pet_entity_1.PetSize.LARGE:
                basePrice = Number(service.largePetPrice);
                break;
        }
        let totalPrice = basePrice;
        if (isRoundTrip) {
            totalPrice *= Number(service.roundTripMultiplier);
        }
        if (needsCrate) {
            totalPrice += Number(service.cratePrice);
        }
        if (needsMedication) {
            totalPrice += Number(service.medicationPrice);
        }
        if (waitReturnHours > 0) {
            totalPrice += waitReturnHours * Number(service.waitReturnHourlyPrice);
        }
        if (isSpecialTime) {
            totalPrice += Number(service.specialTimePrice);
        }
        return Math.round(totalPrice * 100) / 100;
    }
};
exports.ServicesService = ServicesService;
exports.ServicesService = ServicesService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(service_entity_1.Service)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], ServicesService);
//# sourceMappingURL=services.service.js.map