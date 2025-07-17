import { Repository } from 'typeorm';
import { ConfigService } from '@nestjs/config';
import { Payment, PaymentStatus } from './entities/payment.entity';
import { CreatePaymentDto } from './dto/create-payment.dto';
export declare class PaymentsService {
    private paymentsRepository;
    private configService;
    private stripe;
    constructor(paymentsRepository: Repository<Payment>, configService: ConfigService);
    create(createPaymentDto: CreatePaymentDto): Promise<Payment>;
    createStripePaymentIntent(amount: number, bookingId: string): Promise<{
        clientSecret: string;
        paymentId: string;
    }>;
    confirmStripePayment(paymentIntentId: string): Promise<Payment>;
    findAll(): Promise<Payment[]>;
    findOne(id: string): Promise<Payment>;
    findByBooking(bookingId: string): Promise<Payment>;
    updateStatus(id: string, status: PaymentStatus): Promise<Payment>;
}
