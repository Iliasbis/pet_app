"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.LoyaltyTransaction = exports.LoyaltyTransactionType = void 0;
const typeorm_1 = require("typeorm");
const loyalty_account_entity_1 = require("./loyalty-account.entity");
var LoyaltyTransactionType;
(function (LoyaltyTransactionType) {
    LoyaltyTransactionType["EARNED"] = "earned";
    LoyaltyTransactionType["REDEEMED"] = "redeemed";
    LoyaltyTransactionType["REFERRAL"] = "referral";
    LoyaltyTransactionType["BONUS"] = "bonus";
    LoyaltyTransactionType["EXPIRED"] = "expired";
})(LoyaltyTransactionType || (exports.LoyaltyTransactionType = LoyaltyTransactionType = {}));
let LoyaltyTransaction = class LoyaltyTransaction {
};
exports.LoyaltyTransaction = LoyaltyTransaction;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], LoyaltyTransaction.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], LoyaltyTransaction.prototype, "points", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'enum',
        enum: LoyaltyTransactionType,
    }),
    __metadata("design:type", String)
], LoyaltyTransaction.prototype, "type", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], LoyaltyTransaction.prototype, "description", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], LoyaltyTransaction.prototype, "referenceId", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], LoyaltyTransaction.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => loyalty_account_entity_1.LoyaltyAccount, account => account.transactions),
    __metadata("design:type", loyalty_account_entity_1.LoyaltyAccount)
], LoyaltyTransaction.prototype, "loyaltyAccount", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], LoyaltyTransaction.prototype, "loyaltyAccountId", void 0);
exports.LoyaltyTransaction = LoyaltyTransaction = __decorate([
    (0, typeorm_1.Entity)('loyalty_transactions')
], LoyaltyTransaction);
//# sourceMappingURL=loyalty-transaction.entity.js.map