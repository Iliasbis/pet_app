import { Controller, Get, Post, Body, Patch, Param, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { MessagesService } from './messages.service';
import { CreateMessageDto } from './dto/create-message.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Messages')
@Controller('messages')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class MessagesController {
  constructor(private readonly messagesService: MessagesService) {}

  @Get('conversations')
  @ApiOperation({ summary: 'Get user conversations' })
  @ApiResponse({ status: 200, description: 'Conversations retrieved successfully' })
  getConversations(@Request() req) {
    return this.messagesService.getConversations(req.user.id);
  }

  @Get('conversations/:id/messages')
  @ApiOperation({ summary: 'Get messages in a conversation' })
  @ApiResponse({ status: 200, description: 'Messages retrieved successfully' })
  getMessages(@Param('id') conversationId: string) {
    return this.messagesService.getMessages(conversationId);
  }

  @Post('conversations/:id/messages')
  @ApiOperation({ summary: 'Send a message' })
  @ApiResponse({ status: 201, description: 'Message sent successfully' })
  sendMessage(
    @Param('id') conversationId: string,
    @Body() createMessageDto: CreateMessageDto,
    @Request() req,
  ) {
    return this.messagesService.sendMessage({
      ...createMessageDto,
      conversationId,
      senderId: req.user.id,
    });
  }

  @Patch('conversations/:id/read')
  @ApiOperation({ summary: 'Mark messages as read' })
  @ApiResponse({ status: 200, description: 'Messages marked as read' })
  markAsRead(@Param('id') conversationId: string, @Request() req) {
    return this.messagesService.markMessagesAsRead(conversationId, req.user.id);
  }

  @Get('unread/count')
  @ApiOperation({ summary: 'Get unread messages count' })
  @ApiResponse({ status: 200, description: 'Unread count retrieved successfully' })
  getUnreadCount(@Request() req) {
    return this.messagesService.getUnreadCount(req.user.id);
  }
}