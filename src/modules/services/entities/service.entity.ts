import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn } from 'typeorm';

export enum ServiceType {
  LOCAL = 'local', // Up to 15 miles
  STANDARD = 'standard', // 16-30 miles
  LONG = 'long', // 31-50 miles
  EXTENDED = 'extended', // 51+ miles
}

@Entity('services')
export class Service {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  name: string;

  @Column({ type: 'text', nullable: true })
  description: string;

  @Column({
    type: 'enum',
    enum: ServiceType,
  })
  type: ServiceType;

  // Base prices by pet size
  @Column('decimal', { precision: 8, scale: 2 })
  smallPetPrice: number;

  @Column('decimal', { precision: 8, scale: 2 })
  mediumPetPrice: number;

  @Column('decimal', { precision: 8, scale: 2 })
  largePetPrice: number;

  // Add-on prices
  @Column('decimal', { precision: 8, scale: 2, default: 7.00 })
  cratePrice: number;

  @Column('decimal', { precision: 8, scale: 2, default: 5.00 })
  medicationPrice: number;

  @Column('decimal', { precision: 8, scale: 2, default: 15.00 })
  waitReturnHourlyPrice: number;

  @Column('decimal', { precision: 8, scale: 2, default: 10.00 })
  specialTimePrice: number; // Early/Late/Holiday

  // Round trip multiplier (default 1.6 = base + 60%)
  @Column('decimal', { precision: 3, scale: 2, default: 1.60 })
  roundTripMultiplier: number;

  @Column({ default: true })
  isActive: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}