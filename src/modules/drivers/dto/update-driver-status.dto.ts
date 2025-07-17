import { IsEnum } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { DriverStatus } from '../entities/driver.entity';

export class UpdateDriverStatusDto {
  @ApiProperty({ enum: DriverStatus, example: DriverStatus.AVAILABLE })
  @IsEnum(DriverStatus)
  status: DriverStatus;
}