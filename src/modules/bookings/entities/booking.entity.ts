import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, OneToOne } from 'typeorm';
import { User } from '../../users/entities/user.entity';
import { Pet } from '../../pets/entities/pet.entity';
import { Service } from '../../services/entities/service.entity';
import { Payment } from '../../payments/entities/payment.entity';

export enum BookingStatus {
  PENDING = 'pending',
  CONFIRMED = 'confirmed',
  IN_PROGRESS = 'in_progress',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
}

export enum BookingType {
  ONE_WAY = 'one_way',
  ROUND_TRIP = 'round_trip',
}

@Entity('bookings')
export class Booking {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  pickupAddress: string;

  @Column()
  dropOffAddress: string;

  @Column()
  pickupDate: Date;

  @Column()
  pickupTime: string;

  @Column({ nullable: true })
  dropOffDate: Date;

  @Column({ nullable: true })
  dropOffTime: string;

  @Column({
    type: 'enum',
    enum: BookingType,
    default: BookingType.ONE_WAY,
  })
  type: BookingType;

  @Column({
    type: 'enum',
    enum: BookingStatus,
    default: BookingStatus.PENDING,
  })
  status: BookingStatus;

  @Column('decimal', { precision: 8, scale: 2 })
  totalPrice: number;

  // Add-ons
  @Column({ default: false })
  needsCrate: boolean;

  @Column({ default: false })
  needsMedication: boolean;

  @Column({ default: 0 })
  waitReturnHours: number;

  @Column({ default: false })
  isSpecialTime: boolean;

  @Column({ type: 'text', nullable: true })
  specialInstructions: string;

  @Column({ type: 'text', nullable: true })
  adminNotes: string;

  @Column({ nullable: true })
  assignedDriverId: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => User, user => user.bookings)
  user: User;

  @Column()
  userId: string;

  @ManyToOne(() => Pet, pet => pet.bookings)
  pet: Pet;

  @Column()
  petId: string;

  @ManyToOne(() => Service)
  service: Service;

  @Column()
  serviceId: string;

  @OneToOne(() => Payment, payment => payment.booking)
  payment: Payment;
}