import { IsNotEmpty, IsNumber, IsUUID } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreatePaymentIntentDto {
  @ApiProperty({ example: 45.50 })
  @IsNumber()
  amount: number;

  @ApiProperty({ example: 'uuid-of-booking' })
  @IsUUID()
  bookingId: string;
}