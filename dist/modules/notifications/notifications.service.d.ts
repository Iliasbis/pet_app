import { Repository } from 'typeorm';
import { Notification, NotificationType } from './entities/notification.entity';
import { CreateNotificationDto } from './dto/create-notification.dto';
export declare class NotificationsService {
    private notificationsRepository;
    constructor(notificationsRepository: Repository<Notification>);
    create(createNotificationDto: CreateNotificationDto): Promise<Notification>;
    createForUser(userId: string, title: string, message: string, type: NotificationType, data?: any): Promise<Notification>;
    findByUser(userId: string): Promise<Notification[]>;
    findUnreadByUser(userId: string): Promise<Notification[]>;
    markAsRead(id: string, userId: string): Promise<Notification>;
    markAllAsRead(userId: string): Promise<void>;
    remove(id: string, userId: string): Promise<void>;
    getUnreadCount(userId: string): Promise<number>;
}
