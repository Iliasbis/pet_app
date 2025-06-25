import { Module } from '@nestjs/common';
import { AdminService } from './admin.service';
import { AdminController } from './admin.controller';
import { UsersModule } from '../users/users.module';
import { BookingsModule } from '../bookings/bookings.module';
import { PaymentsModule } from '../payments/payments.module';
import { ServicesModule } from '../services/services.module';

@Module({
  imports: [UsersModule, BookingsModule, PaymentsModule, ServicesModule],
  providers: [AdminService],
  controllers: [AdminController],
})
export class AdminModule {}