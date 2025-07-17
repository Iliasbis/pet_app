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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.LoyaltyController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const loyalty_service_1 = require("./loyalty.service");
const jwt_auth_guard_1 = require("../auth/guards/jwt-auth.guard");
let LoyaltyController = class LoyaltyController {
    constructor(loyaltyService) {
        this.loyaltyService = loyaltyService;
    }
    getLoyaltyData(req) {
        return this.loyaltyService.getLoyaltyData(req.user.id);
    }
    getRewards() {
        return this.loyaltyService.getRewards();
    }
    redeemPoints(req, body) {
        return this.loyaltyService.redeemPoints(req.user.id, body.points, body.description);
    }
    processReferral(req, body) {
        return this.loyaltyService.processReferral(body.referralCode, req.user.id);
    }
};
exports.LoyaltyController = LoyaltyController;
__decorate([
    (0, common_1.Get)(),
    (0, swagger_1.ApiOperation)({ summary: 'Get user loyalty data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Loyalty data retrieved successfully' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], LoyaltyController.prototype, "getLoyaltyData", null);
__decorate([
    (0, common_1.Get)('rewards'),
    (0, swagger_1.ApiOperation)({ summary: 'Get available rewards' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Rewards retrieved successfully' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], LoyaltyController.prototype, "getRewards", null);
__decorate([
    (0, common_1.Post)('redeem'),
    (0, swagger_1.ApiOperation)({ summary: 'Redeem loyalty points' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Points redeemed successfully' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", void 0)
], LoyaltyController.prototype, "redeemPoints", null);
__decorate([
    (0, common_1.Post)('referral'),
    (0, swagger_1.ApiOperation)({ summary: 'Process referral code' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Referral processed successfully' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", void 0)
], LoyaltyController.prototype, "processReferral", null);
exports.LoyaltyController = LoyaltyController = __decorate([
    (0, swagger_1.ApiTags)('Loyalty'),
    (0, common_1.Controller)('loyalty'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [loyalty_service_1.LoyaltyService])
], LoyaltyController);
//# sourceMappingURL=loyalty.controller.js.map