import { PetSize } from '../entities/pet.entity';
export declare class CreatePetDto {
    name: string;
    breed: string;
    age: number;
    size: PetSize;
    weight: number;
    color?: string;
    behaviorNotes?: string;
    medicalNotes?: string;
    vetName?: string;
    vetPhone?: string;
    vetAddress?: string;
    emergencyContact?: string;
    emergencyPhone?: string;
}
