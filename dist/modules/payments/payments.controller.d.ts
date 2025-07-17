import { PaymentsService } from './payments.service';
import { CreatePaymentIntentDto } from './dto/create-payment-intent.dto';
import { ConfirmPaymentDto } from './dto/confirm-payment.dto';
export declare class PaymentsController {
    private readonly paymentsService;
    constructor(paymentsService: PaymentsService);
    createPaymentIntent(createPaymentIntentDto: CreatePaymentIntentDto): Promise<{
        clientSecret: string;
        paymentId: string;
    }>;
    confirmPayment(confirmPaymentDto: ConfirmPaymentDto): Promise<import("./entities/payment.entity").Payment>;
    findAll(req: any): Promise<import("./entities/payment.entity").Payment[]>;
    findOne(id: string): Promise<import("./entities/payment.entity").Payment>;
    findByBooking(bookingId: string): Promise<import("./entities/payment.entity").Payment>;
}
