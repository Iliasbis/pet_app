import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Service } from './entities/service.entity';
import { CreateServiceDto } from './dto/create-service.dto';
import { UpdateServiceDto } from './dto/update-service.dto';
import { PetSize } from '../pets/entities/pet.entity';

@Injectable()
export class ServicesService {
  constructor(
    @InjectRepository(Service)
    private servicesRepository: Repository<Service>,
  ) {}

  async create(createServiceDto: CreateServiceDto): Promise<Service> {
    const service = this.servicesRepository.create(createServiceDto);
    return this.servicesRepository.save(service);
  }

  async findAll(): Promise<Service[]> {
    return this.servicesRepository.find({
      where: { isActive: true },
      order: { createdAt: 'ASC' },
    });
  }

  async findOne(id: string): Promise<Service> {
    const service = await this.servicesRepository.findOne({ where: { id } });
    if (!service) {
      throw new NotFoundException(`Service with ID ${id} not found`);
    }
    return service;
  }

  async update(id: string, updateServiceDto: UpdateServiceDto): Promise<Service> {
    const service = await this.findOne(id);
    Object.assign(service, updateServiceDto);
    return this.servicesRepository.save(service);
  }

  async remove(id: string): Promise<void> {
    const service = await this.findOne(id);
    await this.servicesRepository.remove(service);
  }

  calculatePrice(
    service: Service,
    petSize: PetSize,
    isRoundTrip: boolean = false,
    needsCrate: boolean = false,
    needsMedication: boolean = false,
    waitReturnHours: number = 0,
    isSpecialTime: boolean = false,
  ): number {
    let basePrice = 0;

    // Get base price by pet size
    switch (petSize) {
      case PetSize.SMALL:
        basePrice = Number(service.smallPetPrice);
        break;
      case PetSize.MEDIUM:
        basePrice = Number(service.mediumPetPrice);
        break;
      case PetSize.LARGE:
        basePrice = Number(service.largePetPrice);
        break;
    }

    let totalPrice = basePrice;

    // Apply round trip multiplier
    if (isRoundTrip) {
      totalPrice *= Number(service.roundTripMultiplier);
    }

    // Add-ons
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

    return Math.round(totalPrice * 100) / 100; // Round to 2 decimal places
  }
}