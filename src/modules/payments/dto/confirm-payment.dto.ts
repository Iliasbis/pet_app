import { IsNotEmpty, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class ConfirmPaymentDto {
  @ApiProperty({ example: 'pi_1234567890abcdef' })
  @IsString()
  @IsNotEmpty()
  paymentIntentId: string;
}