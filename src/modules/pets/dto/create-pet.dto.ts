import { IsNotEmpty, IsString, IsNumber, IsEnum, IsOptional, Min, Max } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { PetSize } from '../entities/pet.entity';

export class CreatePetDto {
  @ApiProperty({ example: 'Buddy' })
  @IsString()
  @IsNotEmpty()
  name: string;

  @ApiProperty({ example: 'Golden Retriever' })
  @IsString()
  @IsNotEmpty()
  breed: string;

  @ApiProperty({ example: 3, minimum: 0, maximum: 30 })
  @IsNumber()
  @Min(0)
  @Max(30)
  age: number;

  @ApiProperty({ enum: PetSize, example: PetSize.MEDIUM })
  @IsEnum(PetSize)
  size: PetSize;

  @ApiProperty({ example: 45.5, description: 'Weight in pounds' })
  @IsNumber()
  @Min(0)
  weight: number;

  @ApiProperty({ example: 'Brown and White', required: false })
  @IsOptional()
  @IsString()
  color?: string;

  @ApiProperty({ example: 'Friendly but shy with strangers', required: false })
  @IsOptional()
  @IsString()
  behaviorNotes?: string;

  @ApiProperty({ example: 'Allergic to chicken', required: false })
  @IsOptional()
  @IsString()
  medicalNotes?: string;

  @ApiProperty({ example: 'Dr. Smith', required: false })
  @IsOptional()
  @IsString()
  vetName?: string;

  @ApiProperty({ example: '+1234567890', required: false })
  @IsOptional()
  @IsString()
  vetPhone?: string;

  @ApiProperty({ example: '123 Vet St, City, State', required: false })
  @IsOptional()
  @IsString()
  vetAddress?: string;

  @ApiProperty({ example: 'Jane Doe', required: false })
  @IsOptional()
  @IsString()
  emergencyContact?: string;

  @ApiProperty({ example: '+0987654321', required: false })
  @IsOptional()
  @IsString()
  emergencyPhone?: string;
}