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
exports.LoyaltyAccount = exports.LoyaltyTier = void 0;
const typeorm_1 = require("typeorm");
const user_entity_1 = require("../../users/entities/user.entity");
const loyalty_transaction_entity_1 = require("./loyalty-transaction.entity");
var LoyaltyTier;
(function (LoyaltyTier) {
    LoyaltyTier["BRONZE"] = "bronze";
    LoyaltyTier["SILVER"] = "silver";
    LoyaltyTier["GOLD"] = "gold";
    LoyaltyTier["PLATINUM"] = "platinum";
})(LoyaltyTier || (exports.LoyaltyTier = LoyaltyTier = {}));
let LoyaltyAccount = class LoyaltyAccount {
};
exports.LoyaltyAccount = LoyaltyAccount;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], LoyaltyAccount.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: 0 }),
    __metadata("design:type", Number)
], LoyaltyAccount.prototype, "currentPoints", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'enum',
        enum: LoyaltyTier,
        default: LoyaltyTier.BRONZE,
    }),
    __metadata("design:type", String)
], LoyaltyAccount.prototype, "currentTier", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: 0 }),
    __metadata("design:type", Number)
], LoyaltyAccount.prototype, "lifetimePoints", void 0);
__decorate([
    (0, typeorm_1.Column)({ unique: true }),
    __metadata("design:type", String)
], LoyaltyAccount.prototype, "referralCode", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: 0 }),
    __metadata("design:type", Number)
], LoyaltyAccount.prototype, "totalReferrals", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], LoyaltyAccount.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], LoyaltyAccount.prototype, "updatedAt", void 0);
__decorate([
    (0, typeorm_1.OneToOne)(() => user_entity_1.User),
    (0, typeorm_1.JoinColumn)(),
    __metadata("design:type", user_entity_1.User)
], LoyaltyAccount.prototype, "user", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], LoyaltyAccount.prototype, "userId", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => loyalty_transaction_entity_1.LoyaltyTransaction, transaction => transaction.loyaltyAccount),
    __metadata("design:type", Array)
], LoyaltyAccount.prototype, "transactions", void 0);
exports.LoyaltyAccount = LoyaltyAccount = __decorate([
    (0, typeorm_1.Entity)('loyalty_accounts')
], LoyaltyAccount);
//# sourceMappingURL=loyalty-account.entity.js.map