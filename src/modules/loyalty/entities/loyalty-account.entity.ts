import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, OneToOne, OneToMany, JoinColumn } from 'typeorm';
import { User } from '../../users/entities/user.entity';
import { LoyaltyTransaction } from './loyalty-transaction.entity';

export enum LoyaltyTier {
  BRONZE = 'bronze',
  SILVER = 'silver',
  GOLD = 'gold',
  PLATINUM = 'platinum',
}

@Entity('loyalty_accounts')
export class LoyaltyAccount {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ default: 0 })
  currentPoints: number;

  @Column({
    type: 'enum',
    enum: LoyaltyTier,
    default: LoyaltyTier.BRONZE,
  })
  currentTier: LoyaltyTier;

  @Column({ default: 0 })
  lifetimePoints: number;

  @Column({ unique: true })
  referralCode: string;

  @Column({ default: 0 })
  totalReferrals: number;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @OneToOne(() => User)
  @JoinColumn()
  user: User;

  @Column()
  userId: string;

  @OneToMany(() => LoyaltyTransaction, transaction => transaction.loyaltyAccount)
  transactions: LoyaltyTransaction[];
}