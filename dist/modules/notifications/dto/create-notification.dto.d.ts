import { NotificationType } from '../entities/notification.entity';
export declare class CreateNotificationDto {
    title: string;
    message: string;
    type: NotificationType;
    userId: string;
    data?: any;
}
