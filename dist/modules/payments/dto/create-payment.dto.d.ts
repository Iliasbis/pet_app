import { PaymentMethod } from '../entities/payment.entity';
export declare class CreatePaymentDto {
    amount: number;
    method: PaymentMethod;
    bookingId: string;
    stripePaymentIntentId?: string;
    paypalOrderId?: string;
}
