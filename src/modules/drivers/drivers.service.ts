import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Driver, DriverStatus } from './entities/driver.entity';
import { CreateDriverDto } from './dto/create-driver.dto';
import { UpdateDriverDto } from './dto/update-driver.dto';
import * as bcrypt from 'bcryptjs';

@Injectable()
export class DriversService {
  constructor(
    @InjectRepository(Driver)
    private driversRepository: Repository<Driver>,
  ) {}

  async create(createDriverDto: CreateDriverDto): Promise<Driver> {
    const existingDriver = await this.driversRepository.findOne({
      where: { email: createDriverDto.email },
    });

    if (existingDriver) {
      throw new ConflictException('Driver already exists with this email');
    }

    const hashedPassword = await bcrypt.hash(createDriverDto.password, 12);
    const driver = this.driversRepository.create({
      ...createDriverDto,
      password: hashedPassword,
    });

    return this.driversRepository.save(driver);
  }

  async findAll(): Promise<Driver[]> {
    return this.driversRepository.find({
      relations: ['bookings'],
      order: { createdAt: 'DESC' },
    });
  }

  async findById(id: string): Promise<Driver> {
    const driver = await this.driversRepository.findOne({
      where: { id },
      relations: ['bookings'],
    });

    if (!driver) {
      throw new NotFoundException(`Driver with ID ${id} not found`);
    }

    return driver;
  }

  async findByEmail(email: string): Promise<Driver> {
    return this.driversRepository.findOne({ where: { email } });
  }

  async findAvailableDrivers(): Promise<Driver[]> {
    return this.driversRepository.find({
      where: { 
        status: DriverStatus.AVAILABLE,
        isActive: true,
        isVerified: true,
      },
    });
  }

  async update(id: string, updateDriverDto: UpdateDriverDto): Promise<Driver> {
    const driver = await this.findById(id);
    
    if (updateDriverDto.password) {
      updateDriverDto.password = await bcrypt.hash(updateDriverDto.password, 12);
    }

    Object.assign(driver, updateDriverDto);
    return this.driversRepository.save(driver);
  }

  async updateStatus(id: string, status: DriverStatus): Promise<Driver> {
    const driver = await this.findById(id);
    driver.status = status;
    return this.driversRepository.save(driver);
  }

  async updateLocation(id: string, latitude: number, longitude: number): Promise<Driver> {
    const driver = await this.findById(id);
    driver.currentLatitude = latitude;
    driver.currentLongitude = longitude;
    return this.driversRepository.save(driver);
  }

  async updateEarnings(id: string, amount: number): Promise<Driver> {
    const driver = await this.findById(id);
    driver.totalEarnings = Number(driver.totalEarnings) + amount;
    driver.totalRides += 1;
    return this.driversRepository.save(driver);
  }

  async remove(id: string): Promise<void> {
    const driver = await this.findById(id);
    await this.driversRepository.remove(driver);
  }

  async getDriverStats(id: string) {
    const driver = await this.findById(id);
    
    // Calculate additional stats
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
      // Additional stats would be calculated from bookings
    };
  }
}