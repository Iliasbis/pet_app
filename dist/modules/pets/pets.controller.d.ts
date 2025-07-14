import { PetsService } from './pets.service';
import { CreatePetDto } from './dto/create-pet.dto';
import { UpdatePetDto } from './dto/update-pet.dto';
export declare class PetsController {
    private readonly petsService;
    constructor(petsService: PetsService);
    create(createPetDto: CreatePetDto, req: any): Promise<import("./entities/pet.entity").Pet>;
    findAll(req: any): Promise<import("./entities/pet.entity").Pet[]>;
    findOne(id: string, req: any): Promise<import("./entities/pet.entity").Pet>;
    update(id: string, updatePetDto: UpdatePetDto, req: any): Promise<import("./entities/pet.entity").Pet>;
    remove(id: string, req: any): Promise<void>;
}
