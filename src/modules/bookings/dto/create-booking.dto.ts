import { IsNotEmpty, IsString, IsDateString, IsEnum, IsOptional, IsBoolean, IsNumber, IsUUID, Min } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { BookingType } from '../entities/booking.entity';
import { PetSize } from '../../pets/entities/pet.entity';

export class CreateBookingDto {
  @ApiProperty({ example: '123 Main St, City, State 12345' })
  @IsString()
  @IsNotEmpty()
  pickupAddress: string;

  @ApiProperty({ example: '456 Oak Ave, City, State 12345' })
  @IsString()
  @IsNotEmpty()
  dropOffAddress: string;

  @ApiProperty({ example: '2024-01-15' })
  @IsDateString()
  pickupDate: Date;

  @ApiProperty({ example: '09:00' })
  @IsString()
  @IsNotEmpty()
  pickupTime: string;

  @ApiProperty({ example: '2024-01-15', required: false })
  @IsOptional()
  @IsDateString()
  dropOffDate?: Date;

  @ApiProperty({ example: '17:00', required: false })
  @IsOptional()
  @IsString()
  dropOffTime?: string;

  @ApiProperty({ enum: BookingType, example: BookingType.ONE_WAY })
  @IsEnum(BookingType)
  type: BookingType;

  @ApiProperty({ example: 'uuid-of-pet' })
  @IsUUID()
  petId: string;

  @ApiProperty({ example: 'uuid-of-service' })
  @IsUUID()
  serviceId: string;

  @ApiProperty({ enum: PetSize, example: PetSize.MEDIUM })
  @IsEnum(PetSize)
  petSize: PetSize;

  @ApiProperty({ example: false, required: false })
  @IsOptional()
  @IsBoolean()
  needsCrate?: boolean;

  @ApiProperty({ example: false, required: false })
  @IsOptional()
  @IsBoolean()
  needsMedication?: boolean;

  @ApiProperty({ example: 0, required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  waitReturnHours?: number;

  @ApiProperty({ example: false, required: false })
  @IsOptional()
  @IsBoolean()
  isSpecialTime?: boolean;

  @ApiProperty({ example: 'Please handle with care', required: false })
  @IsOptional()
  @IsString()
  specialInstructions?: string;
}