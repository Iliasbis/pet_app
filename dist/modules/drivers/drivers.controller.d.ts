import { DriversService } from './drivers.service';
import { CreateDriverDto } from './dto/create-driver.dto';
import { UpdateDriverDto } from './dto/update-driver.dto';
import { UpdateDriverStatusDto } from './dto/update-driver-status.dto';
import { UpdateLocationDto } from './dto/update-location.dto';
export declare class DriversController {
    private readonly driversService;
    constructor(driversService: DriversService);
    create(createDriverDto: CreateDriverDto): Promise<import("./entities/driver.entity").Driver>;
    findAll(): Promise<import("./entities/driver.entity").Driver[]>;
    findAvailable(): Promise<import("./entities/driver.entity").Driver[]>;
    getProfile(req: any): Promise<import("./entities/driver.entity").Driver>;
    getStats(req: any): Promise<{
        totalRides: number;
        totalEarnings: number;
        rating: number;
        status: import("./entities/driver.entity").DriverStatus;
    }>;
    findOne(id: string): Promise<import("./entities/driver.entity").Driver>;
    updateProfile(req: any, updateDriverDto: UpdateDriverDto): Promise<import("./entities/driver.entity").Driver>;
    updateStatus(req: any, updateStatusDto: UpdateDriverStatusDto): Promise<import("./entities/driver.entity").Driver>;
    updateLocation(req: any, updateLocationDto: UpdateLocationDto): Promise<import("./entities/driver.entity").Driver>;
    update(id: string, updateDriverDto: UpdateDriverDto): Promise<import("./entities/driver.entity").Driver>;
    remove(id: string): Promise<void>;
}
