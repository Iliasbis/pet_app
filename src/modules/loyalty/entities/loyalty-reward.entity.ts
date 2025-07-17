import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn } from 'typeorm';

export enum RewardType {
  DISCOUNT = 'discount',
  FREE_RIDE = 'free_ride',
  UPGRADE = 'upgrade',
  MERCHANDISE = 'merchandise',
}

@Entity('loyalty_rewards')
export class LoyaltyReward {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  name: string;

  @Column({ type: 'text' })
  description: string;

  @Column()
  pointsCost: number;

  @Column({
    type: 'enum',
    enum: RewardType,
  })
  type: RewardType;

  @Column({ type: 'decimal', precision: 8, scale: 2, nullable: true })
  discountAmount: number;

  @Column({ nullable: true })
  discountType: string; // 'percentage' or 'fixed'

  @Column({ default: true })
  isActive: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}