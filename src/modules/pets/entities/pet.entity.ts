import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, OneToMany } from 'typeorm';
import { User } from '../../users/entities/user.entity';
import { Booking } from '../../bookings/entities/booking.entity';

export enum PetSize {
  SMALL = 'small', // Under 25 lbs
  MEDIUM = 'medium', // 25-60 lbs
  LARGE = 'large', // Over 60 lbs
}

@Entity('pets')
export class Pet {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  name: string;

  @Column()
  breed: string;

  @Column()
  age: number;

  @Column({
    type: 'enum',
    enum: PetSize,
  })
  size: PetSize;

  @Column()
  weight: number;

  @Column({ nullable: true })
  color: string;

  @Column({ type: 'text', nullable: true })
  behaviorNotes: string;

  @Column({ type: 'text', nullable: true })
  medicalNotes: string;

  @Column({ nullable: true })
  vetName: string;

  @Column({ nullable: true })
  vetPhone: string;

  @Column({ nullable: true })
  vetAddress: string;

  @Column({ nullable: true })
  emergencyContact: string;

  @Column({ nullable: true })
  emergencyPhone: string;

  @Column({ default: true })
  isActive: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => User, user => user.pets)
  owner: User;

  @Column()
  ownerId: string;

  @OneToMany(() => Booking, booking => booking.pet)
  bookings: Booking[];
}