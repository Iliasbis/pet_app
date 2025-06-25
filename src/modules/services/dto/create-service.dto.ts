import { IsNotEmpty, IsString, IsNumber, IsEnum, IsOptional, IsBoolean, Min } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { ServiceType } from '../entities/service.entity';

export class CreateServiceDto {
  @ApiProperty({ example: 'Local Pet Transport' })
  @IsString()
  @IsNotEmpty()
  name: string;

  @ApiProperty({ example: 'Transportation within 15 miles', required: false })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ enum: ServiceType, example: ServiceType.LOCAL })
  @IsEnum(ServiceType)
  type: ServiceType;

  @ApiProperty({ example: 25.00, description: 'Base price for small pets' })
  @IsNumber()
  @Min(0)
  smallPetPrice: number;

  @ApiProperty({ example: 35.00, description: 'Base price for medium pets' })
  @IsNumber()
  @Min(0)
  mediumPetPrice: number;

  @ApiProperty({ example: 45.00, description: 'Base price for large pets' })
  @IsNumber()
  @Min(0)
  largePetPrice: number;

  @ApiProperty({ example: 7.00, required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  cratePrice?: number;

  @ApiProperty({ example: 5.00, required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  medicationPrice?: number;

  @ApiProperty({ example: 15.00, required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  waitReturnHourlyPrice?: number;

  @ApiProperty({ example: 10.00, required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  specialTimePrice?: number;

  @ApiProperty({ example: 1.60, required: false })
  @IsOptional()
  @IsNumber()
  @Min(1)
  roundTripMultiplier?: number;

  @ApiProperty({ example: true, required: false })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}