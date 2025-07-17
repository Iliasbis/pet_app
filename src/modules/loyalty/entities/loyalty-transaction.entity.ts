import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne } from 'typeorm';
import { LoyaltyAccount } from './loyalty-account.entity';

export enum LoyaltyTransactionType {
  EARNED = 'earned',
  REDEEMED = 'redeemed',
  REFERRAL = 'referral',
  BONUS = 'bonus',
  EXPIRED = 'expired',
}

@Entity('loyalty_transactions')
export class LoyaltyTransaction {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  points: number;

  @Column({
    type: 'enum',
    enum: LoyaltyTransactionType,
  })
  type: LoyaltyTransactionType;

  @Column()
  description: string;

  @Column({ nullable: true })
  referenceId: string; // booking ID, reward ID, etc.

  @CreateDateColumn()
  createdAt: Date;

  @ManyToOne(() => LoyaltyAccount, account => account.transactions)
  loyaltyAccount: LoyaltyAccount;

  @Column()
  loyaltyAccountId: string;
}