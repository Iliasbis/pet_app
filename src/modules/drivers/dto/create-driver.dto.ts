import { IsEmail, IsNotEmpty, IsString, MinLength, IsOptional, IsEnum } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { DriverStatus } from '../entities/driver.entity';

export class CreateDriverDto {
  @ApiProperty({ example: 'driver@example.com' })
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @ApiProperty({ example: 'password123', minLength: 6 })
  @IsString()
  @MinLength(6)
  password: string;

  @ApiProperty({ example: 'John' })
  @IsString()
  @IsNotEmpty()
  firstName: string;

  @ApiProperty({ example: 'Doe' })
  @IsString()
  @IsNotEmpty()
  lastName: string;

  @ApiProperty({ example: '+1234567890', required: false })
  @IsOptional()
  @IsString()
  phone?: string;

  @ApiProperty({ example: '123 Main St, City, State 12345', required: false })
  @IsOptional()
  @IsString()
  address?: string;

  @ApiProperty({ example: 'DL123456789', required: false })
  @IsOptional()
  @IsString()
  licenseNumber?: string;

  @ApiProperty({ example: '2020 Honda Civic - ABC123', required: false })
  @IsOptional()
  @IsString()
  vehicleInfo?: string;

  @ApiProperty({ enum: DriverStatus, default: DriverStatus.OFFLINE, required: false })
  @IsOptional()
  @IsEnum(DriverStatus)
  status?: DriverStatus;
}