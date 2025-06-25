import { IsNotEmpty, IsNumber, IsEnum, IsUUID, IsOptional, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { PaymentMethod } from '../entities/payment.entity';

export class CreatePaymentDto {
  @ApiProperty({ example: 45.50 })
  @IsNumber()
  amount: number;

  @ApiProperty({ enum: PaymentMethod, example: PaymentMethod.STRIPE })
  @IsEnum(PaymentMethod)
  method: PaymentMethod;

  @ApiProperty({ example: 'uuid-of-booking' })
  @IsUUID()
  bookingId: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  stripePaymentIntentId?: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  paypalOrderId?: string;
}