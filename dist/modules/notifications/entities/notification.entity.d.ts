import { User } from '../../users/entities/user.entity';
export declare enum NotificationType {
    BOOKING_CONFIRMED = "booking_confirmed",
    DRIVER_ASSIGNED = "driver_assigned",
    RIDE_STARTED = "ride_started",
    RIDE_COMPLETED = "ride_completed",
    PAYMENT_PROCESSED = "payment_processed",
    MESSAGE = "message",
    PROMOTION = "promotion",
    SYSTEM = "system"
}
export declare class Notification {
    id: string;
    title: string;
    message: string;
    type: NotificationType;
    data: any;
    isRead: boolean;
    createdAt: Date;
    updatedAt: Date;
    user: User;
    userId: string;
}
