import { Booking } from '../../bookings/entities/booking.entity';
export declare enum PaymentStatus {
    PENDING = "pending",
    COMPLETED = "completed",
    FAILED = "failed",
    REFUNDED = "refunded"
}
export declare enum PaymentMethod {
    STRIPE = "stripe",
    PAYPAL = "paypal",
    CASH = "cash"
}
export declare class Payment {
    id: string;
    amount: number;
    status: PaymentStatus;
    method: PaymentMethod;
    stripePaymentIntentId: string;
    paypalOrderId: string;
    metadata: string;
    createdAt: Date;
    updatedAt: Date;
    booking: Booking;
    bookingId: string;
}
