import { Repository } from 'typeorm';
import { Message } from './entities/message.entity';
import { Conversation } from './entities/conversation.entity';
import { CreateMessageDto } from './dto/create-message.dto';
export declare class MessagesService {
    private messagesRepository;
    private conversationsRepository;
    constructor(messagesRepository: Repository<Message>, conversationsRepository: Repository<Conversation>);
    createConversation(customerId: string, driverId: string, bookingId?: string): Promise<Conversation>;
    sendMessage(createMessageDto: CreateMessageDto): Promise<Message>;
    getConversations(userId: string): Promise<Conversation[]>;
    getMessages(conversationId: string): Promise<Message[]>;
    markMessagesAsRead(conversationId: string, userId: string): Promise<void>;
    getUnreadCount(userId: string): Promise<number>;
}
