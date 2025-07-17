import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Message } from './entities/message.entity';
import { Conversation } from './entities/conversation.entity';
import { CreateMessageDto } from './dto/create-message.dto';

@Injectable()
export class MessagesService {
  constructor(
    @InjectRepository(Message)
    private messagesRepository: Repository<Message>,
    @InjectRepository(Conversation)
    private conversationsRepository: Repository<Conversation>,
  ) {}

  async createConversation(
    customerId: string,
    driverId: string,
    bookingId?: string,
  ): Promise<Conversation> {
    // Check if conversation already exists
    let conversation = await this.conversationsRepository.findOne({
      where: { customerId, driverId, bookingId },
    });

    if (!conversation) {
      conversation = this.conversationsRepository.create({
        customerId,
        driverId,
        bookingId,
      });
      conversation = await this.conversationsRepository.save(conversation);
    }

    return conversation;
  }

  async sendMessage(createMessageDto: CreateMessageDto): Promise<Message> {
    const message = this.messagesRepository.create(createMessageDto);
    const savedMessage = await this.messagesRepository.save(message);

    // Update conversation last message
    await this.conversationsRepository.update(
      { id: createMessageDto.conversationId },
      {
        lastMessage: createMessageDto.content,
        lastMessageAt: new Date(),
      },
    );

    return savedMessage;
  }

  async getConversations(userId: string): Promise<Conversation[]> {
    return this.conversationsRepository.find({
      where: [
        { customerId: userId },
        { driverId: userId },
      ],
      relations: ['customer', 'driver', 'booking'],
      order: { lastMessageAt: 'DESC' },
    });
  }

  async getMessages(conversationId: string): Promise<Message[]> {
    return this.messagesRepository.find({
      where: { conversationId },
      relations: ['sender', 'recipient'],
      order: { createdAt: 'ASC' },
    });
  }

  async markMessagesAsRead(conversationId: string, userId: string): Promise<void> {
    await this.messagesRepository.update(
      {
        conversationId,
        recipientId: userId,
        isRead: false,
      },
      { isRead: true },
    );
  }

  async getUnreadCount(userId: string): Promise<number> {
    return this.messagesRepository.count({
      where: {
        recipientId: userId,
        isRead: false,
      },
    });
  }
}