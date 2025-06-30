"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PaymentsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const config_1 = require("@nestjs/config");
const payment_entity_1 = require("./entities/payment.entity");
const stripe_1 = require("stripe");
let PaymentsService = class PaymentsService {
    constructor(paymentsRepository, configService) {
        this.paymentsRepository = paymentsRepository;
        this.configService = configService;
        this.stripe = new stripe_1.default(this.configService.get('STRIPE_SECRET_KEY'), {
            apiVersion: '2023-10-16',
        });
    }
    async create(createPaymentDto) {
        const payment = this.paymentsRepository.create(createPaymentDto);
        return this.paymentsRepository.save(payment);
    }
    async createStripePaymentIntent(amount, bookingId) {
        const paymentIntent = await this.stripe.paymentIntents.create({
            amount: Math.round(amount * 100),
            currency: 'usd',
            metadata: {
                bookingId,
            },
        });
        const payment = await this.create({
            amount,
            method: payment_entity_1.PaymentMethod.STRIPE,
            bookingId,
            stripePaymentIntentId: paymentIntent.id,
        });
        return {
            clientSecret: paymentIntent.client_secret,
            paymentId: payment.id,
        };
    }
    async confirmStripePayment(paymentIntentId) {
        const payment = await this.paymentsRepository.findOne({
            where: { stripePaymentIntentId: paymentIntentId },
        });
        if (!payment) {
            throw new common_1.NotFoundException('Payment not found');
        }
        payment.status = payment_entity_1.PaymentStatus.COMPLETED;
        return this.paymentsRepository.save(payment);
    }
    async findAll() {
        return this.paymentsRepository.find({
            relations: ['booking'],
            order: { createdAt: 'DESC' },
        });
    }
    async findOne(id) {
        const payment = await this.paymentsRepository.findOne({
            where: { id },
            relations: ['booking'],
        });
        if (!payment) {
            throw new common_1.NotFoundException(`Payment with ID ${id} not found`);
        }
        return payment;
    }
    async findByBooking(bookingId) {
        return this.paymentsRepository.findOne({
            where: { bookingId },
            relations: ['booking'],
        });
    }
    async updateStatus(id, status) {
        const payment = await this.findOne(id);
        payment.status = status;
        return this.paymentsRepository.save(payment);
    }
};
exports.PaymentsService = PaymentsService;
exports.PaymentsService = PaymentsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(payment_entity_1.Payment)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        config_1.ConfigService])
], PaymentsService);
//# sourceMappingURL=payments.service.js.map