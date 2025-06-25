import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Pet } from './entities/pet.entity';
import { CreatePetDto } from './dto/create-pet.dto';
import { UpdatePetDto } from './dto/update-pet.dto';

@Injectable()
export class PetsService {
  constructor(
    @InjectRepository(Pet)
    private petsRepository: Repository<Pet>,
  ) {}

  async create(createPetDto: CreatePetDto, ownerId: string): Promise<Pet> {
    const pet = this.petsRepository.create({
      ...createPetDto,
      ownerId,
    });
    return this.petsRepository.save(pet);
  }

  async findAll(): Promise<Pet[]> {
    return this.petsRepository.find({
      relations: ['owner'],
    });
  }

  async findByOwner(ownerId: string): Promise<Pet[]> {
    return this.petsRepository.find({
      where: { ownerId },
      relations: ['owner'],
    });
  }

  async findOne(id: string, userId?: string): Promise<Pet> {
    const pet = await this.petsRepository.findOne({
      where: { id },
      relations: ['owner'],
    });

    if (!pet) {
      throw new NotFoundException(`Pet with ID ${id} not found`);
    }

    // Check if user has permission to view this pet
    if (userId && pet.ownerId !== userId) {
      throw new ForbiddenException('You can only access your own pets');
    }

    return pet;
  }

  async update(id: string, updatePetDto: UpdatePetDto, userId?: string): Promise<Pet> {
    const pet = await this.findOne(id, userId);
    Object.assign(pet, updatePetDto);
    return this.petsRepository.save(pet);
  }

  async remove(id: string, userId?: string): Promise<void> {
    const pet = await this.findOne(id, userId);
    await this.petsRepository.remove(pet);
  }
}