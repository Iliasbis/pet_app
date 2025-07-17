import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { JwtModule } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';

// Modules
import { AuthModule } from './modules/auth/auth.module';
import { UsersModule } from './modules/users/users.module';
import { PetsModule } from './modules/pets/pets.module';
import { BookingsModule } from './modules/bookings/bookings.module';
import { ServicesModule } from './modules/services/services.module';
import { PaymentsModule } from './modules/payments/payments.module';
import { AdminModule } from './modules/admin/admin.module';
import { DriversModule } from './modules/drivers/drivers.module';
import { NotificationsModule } from './modules/notifications/notifications.module';
import { MessagesModule } from './modules/messages/messages.module';
import { LoyaltyModule } from './modules/loyalty/loyalty.module';

// Entities
import { User } from './modules/users/entities/user.entity';
import { Pet } from './modules/pets/entities/pet.entity';
import { Booking } from './modules/bookings/entities/booking.entity';
import { Service } from './modules/services/entities/service.entity';
import { Payment } from './modules/payments/entities/payment.entity';
import { Driver } from './modules/drivers/entities/driver.entity';
import { Notification } from './modules/notifications/entities/notification.entity';
import { Message } from './modules/messages/entities/message.entity';
import { Conversation } from './modules/messages/entities/conversation.entity';
import { LoyaltyAccount } from './modules/loyalty/entities/loyalty-account.entity';
import { LoyaltyTransaction } from './modules/loyalty/entities/loyalty-transaction.entity';
import { LoyaltyReward } from './modules/loyalty/entities/loyalty-reward.entity';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: configService.get('DATABASE_HOST'),
        port: configService.get('DATABASE_PORT'),
        username: configService.get('DATABASE_USER'),
        password: configService.get('DATABASE_PASSWORD'),
        database: configService.get('DATABASE_NAME'),
        entities: [
          User, 
          Pet, 
          Booking, 
          Service, 
          Payment, 
          Driver, 
          Notification, 
          Message, 
          Conversation, 
          LoyaltyAccount, 
          LoyaltyTransaction, 
          LoyaltyReward
        ],
        synchronize: true, // Set to false in production
        logging: true,
      }),
      inject: [ConfigService],
    }),
    JwtModule.registerAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        secret: configService.get('JWT_SECRET'),
        signOptions: { expiresIn: configService.get('JWT_EXPIRES_IN') },
      }),
      inject: [ConfigService],
    }),
    PassportModule.register({ defaultStrategy: 'jwt' }),
    AuthModule,
    UsersModule,
    PetsModule,
    BookingsModule,
    ServicesModule,
    PaymentsModule,
    AdminModule,
    DriversModule,
    NotificationsModule,
    MessagesModule,
    LoyaltyModule,
  ],
})
export class AppModule { }