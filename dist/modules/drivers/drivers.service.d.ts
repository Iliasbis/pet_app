import { Repository } from 'typeorm';
import { Driver, DriverStatus } from './entities/driver.entity';
import { CreateDriverDto } from './dto/create-driver.dto';
import { UpdateDriverDto } from './dto/update-driver.dto';
export declare class DriversService {
    private driversRepository;
    constructor(driversRepository: Repository<Driver>);
    create(createDriverDto: CreateDriverDto): Promise<Driver>;
    findAll(): Promise<Driver[]>;
    findById(id: string): Promise<Driver>;
    findByEmail(email: string): Promise<Driver>;
    findAvailableDrivers(): Promise<Driver[]>;
    update(id: string, updateDriverDto: UpdateDriverDto): Promise<Driver>;
    updateStatus(id: string, status: DriverStatus): Promise<Driver>;
    updateLocation(id: string, latitude: number, longitude: number): Promise<Driver>;
    updateEarnings(id: string, amount: number): Promise<Driver>;
    remove(id: string): Promise<void>;
    getDriverStats(id: string): Promise<{
        totalRides: number;
        totalEarnings: number;
        rating: number;
        status: DriverStatus;
    }>;
}
