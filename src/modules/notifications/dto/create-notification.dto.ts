import { IsNotEmpty, IsString, IsEnum, IsUUID, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { NotificationType } from '../entities/notification.entity';

export class CreateNotificationDto {
  @ApiProperty({ example: 'Booking Confirmed' })
  @IsString()
  @IsNotEmpty()
  title: string;

  @ApiProperty({ example: 'Your booking has been confirmed for tomorrow at 10:00 AM' })
  @IsString()
  @IsNotEmpty()
  message: string;

  @ApiProperty({ enum: NotificationType, example: NotificationType.BOOKING_CONFIRMED })
  @IsEnum(NotificationType)
  type: NotificationType;

  @ApiProperty({ example: 'uuid-of-user' })
  @IsUUID()
  userId: string;

  @ApiProperty({ required: false, description: 'Additional data for the notification' })
  @IsOptional()
  data?: any;
}