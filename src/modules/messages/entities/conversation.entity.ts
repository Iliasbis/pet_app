import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, OneToMany, ManyToOne } from 'typeorm';
import { User } from '../../users/entities/user.entity';
import { Booking } from '../../bookings/entities/booking.entity';
import { Message } from './message.entity';

@Entity('conversations')
export class Conversation {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ nullable: true })
  bookingId: string;

  @Column()
  customerId: string;

  @Column({ nullable: true })
  driverId: string;

  @Column({ nullable: true })
  lastMessage: string;

  @Column({ nullable: true })
  lastMessageAt: Date;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => User)
  customer: User;

  @ManyToOne(() => User)
  driver: User;

  @ManyToOne(() => Booking)
  booking: Booking;

  @OneToMany(() => Message, message => message.conversation)
  messages: Message[];
}