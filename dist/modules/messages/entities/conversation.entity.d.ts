import { User } from '../../users/entities/user.entity';
import { Booking } from '../../bookings/entities/booking.entity';
import { Message } from './message.entity';
export declare class Conversation {
    id: string;
    bookingId: string;
    customerId: string;
    driverId: string;
    lastMessage: string;
    lastMessageAt: Date;
    createdAt: Date;
    updatedAt: Date;
    customer: User;
    driver: User;
    booking: Booking;
    messages: Message[];
}
