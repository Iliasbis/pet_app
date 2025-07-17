"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppModule = void 0;
const common_1 = require("@nestjs/common");
const config_1 = require("@nestjs/config");
const typeorm_1 = require("@nestjs/typeorm");
const jwt_1 = require("@nestjs/jwt");
const passport_1 = require("@nestjs/passport");
const auth_module_1 = require("./modules/auth/auth.module");
const users_module_1 = require("./modules/users/users.module");
const pets_module_1 = require("./modules/pets/pets.module");
const bookings_module_1 = require("./modules/bookings/bookings.module");
const services_module_1 = require("./modules/services/services.module");
const payments_module_1 = require("./modules/payments/payments.module");
const admin_module_1 = require("./modules/admin/admin.module");
const drivers_module_1 = require("./modules/drivers/drivers.module");
const notifications_module_1 = require("./modules/notifications/notifications.module");
const messages_module_1 = require("./modules/messages/messages.module");
const loyalty_module_1 = require("./modules/loyalty/loyalty.module");
const user_entity_1 = require("./modules/users/entities/user.entity");
const pet_entity_1 = require("./modules/pets/entities/pet.entity");
const booking_entity_1 = require("./modules/bookings/entities/booking.entity");
const service_entity_1 = require("./modules/services/entities/service.entity");
const payment_entity_1 = require("./modules/payments/entities/payment.entity");
const driver_entity_1 = require("./modules/drivers/entities/driver.entity");
const notification_entity_1 = require("./modules/notifications/entities/notification.entity");
const message_entity_1 = require("./modules/messages/entities/message.entity");
const conversation_entity_1 = require("./modules/messages/entities/conversation.entity");
const loyalty_account_entity_1 = require("./modules/loyalty/entities/loyalty-account.entity");
const loyalty_transaction_entity_1 = require("./modules/loyalty/entities/loyalty-transaction.entity");
const loyalty_reward_entity_1 = require("./modules/loyalty/entities/loyalty-reward.entity");
let AppModule = class AppModule {
};
exports.AppModule = AppModule;
exports.AppModule = AppModule = __decorate([
    (0, common_1.Module)({
        imports: [
            config_1.ConfigModule.forRoot({
                isGlobal: true,
            }),
            typeorm_1.TypeOrmModule.forRootAsync({
                imports: [config_1.ConfigModule],
                useFactory: (configService) => ({
                    type: 'mysql',
                    host: configService.get('DATABASE_HOST'),
                    port: configService.get('DATABASE_PORT'),
                    username: configService.get('DATABASE_USER'),
                    password: configService.get('DATABASE_PASSWORD'),
                    database: configService.get('DATABASE_NAME'),
                    entities: [
                        user_entity_1.User,
                        pet_entity_1.Pet,
                        booking_entity_1.Booking,
                        service_entity_1.Service,
                        payment_entity_1.Payment,
                        driver_entity_1.Driver,
                        notification_entity_1.Notification,
                        message_entity_1.Message,
                        conversation_entity_1.Conversation,
                        loyalty_account_entity_1.LoyaltyAccount,
                        loyalty_transaction_entity_1.LoyaltyTransaction,
                        loyalty_reward_entity_1.LoyaltyReward
                    ],
                    synchronize: true,
                    logging: true,
                }),
                inject: [config_1.ConfigService],
            }),
            jwt_1.JwtModule.registerAsync({
                imports: [config_1.ConfigModule],
                useFactory: (configService) => ({
                    secret: configService.get('JWT_SECRET'),
                    signOptions: { expiresIn: configService.get('JWT_EXPIRES_IN') },
                }),
                inject: [config_1.ConfigService],
            }),
            passport_1.PassportModule.register({ defaultStrategy: 'jwt' }),
            auth_module_1.AuthModule,
            users_module_1.UsersModule,
            pets_module_1.PetsModule,
            bookings_module_1.BookingsModule,
            services_module_1.ServicesModule,
            payments_module_1.PaymentsModule,
            admin_module_1.AdminModule,
            drivers_module_1.DriversModule,
            notifications_module_1.NotificationsModule,
            messages_module_1.MessagesModule,
            loyalty_module_1.LoyaltyModule,
        ],
    })
], AppModule);
//# sourceMappingURL=app.module.js.map