import { IsNotEmpty, IsString, IsUUID } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateMessageDto {
  @ApiProperty({ example: 'Hello, I have a question about my booking.' })
  @IsString()
  @IsNotEmpty()
  content: string;

  @ApiProperty({ example: 'uuid-of-conversation' })
  @IsUUID()
  conversationId: string;

  @ApiProperty({ example: 'uuid-of-sender' })
  @IsUUID()
  senderId: string;

  @ApiProperty({ example: 'uuid-of-recipient' })
  @IsUUID()
  recipientId: string;
}