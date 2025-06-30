import { Repository } from 'typeorm';
import { Pet } from './entities/pet.entity';
import { CreatePetDto } from './dto/create-pet.dto';
import { UpdatePetDto } from './dto/update-pet.dto';
export declare class PetsService {
    private petsRepository;
    constructor(petsRepository: Repository<Pet>);
    create(createPetDto: CreatePetDto, ownerId: string): Promise<Pet>;
    findAll(): Promise<Pet[]>;
    findByOwner(ownerId: string): Promise<Pet[]>;
    findOne(id: string, userId?: string): Promise<Pet>;
    update(id: string, updatePetDto: UpdatePetDto, userId?: string): Promise<Pet>;
    remove(id: string, userId?: string): Promise<void>;
}
