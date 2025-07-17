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
exports.LoyaltyReward = exports.RewardType = void 0;
const typeorm_1 = require("typeorm");
var RewardType;
(function (RewardType) {
    RewardType["DISCOUNT"] = "discount";
    RewardType["FREE_RIDE"] = "free_ride";
    RewardType["UPGRADE"] = "upgrade";
    RewardType["MERCHANDISE"] = "merchandise";
})(RewardType || (exports.RewardType = RewardType = {}));
let LoyaltyReward = class LoyaltyReward {
};
exports.LoyaltyReward = LoyaltyReward;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], LoyaltyReward.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], LoyaltyReward.prototype, "name", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'text' }),
    __metadata("design:type", String)
], LoyaltyReward.prototype, "description", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], LoyaltyReward.prototype, "pointsCost", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'enum',
        enum: RewardType,
    }),
    __metadata("design:type", String)
], LoyaltyReward.prototype, "type", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'decimal', precision: 8, scale: 2, nullable: true }),
    __metadata("design:type", Number)
], LoyaltyReward.prototype, "discountAmount", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], LoyaltyReward.prototype, "discountType", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: true }),
    __metadata("design:type", Boolean)
], LoyaltyReward.prototype, "isActive", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], LoyaltyReward.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], LoyaltyReward.prototype, "updatedAt", void 0);
exports.LoyaltyReward = LoyaltyReward = __decorate([
    (0, typeorm_1.Entity)('loyalty_rewards')
], LoyaltyReward);
//# sourceMappingURL=loyalty-reward.entity.js.map