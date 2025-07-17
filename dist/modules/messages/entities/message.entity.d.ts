import { User } from '../../users/entities/user.entity';
import { Conversation } from './conversation.entity';
export declare class Message {
    id: string;
    content: string;
    senderId: string;
    recipientId: string;
    isRead: boolean;
    createdAt: Date;
    sender: User;
    recipient: User;
    conversation: Conversation;
    conversationId: string;
}
