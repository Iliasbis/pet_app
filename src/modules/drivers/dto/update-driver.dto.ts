import { PartialType } from '@nestjs/swagger';
import { CreateDriverDto } from './create-driver.dto';
import { IsOptional, IsNumber, IsBoolean } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateDriverDto extends PartialType(CreateDriverDto) {
  @ApiProperty({ required: false })
  @IsOptional()
  @IsNumber()
  currentLatitude?: number;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsNumber()
  currentLongitude?: number;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsNumber()
  rating?: number;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsNumber()
  totalRides?: number;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsNumber()
  totalEarnings?: number;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsBoolean()
  isVerified?: boolean;
}