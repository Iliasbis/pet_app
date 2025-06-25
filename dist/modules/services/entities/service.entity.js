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
exports.Service = exports.ServiceType = void 0;
const typeorm_1 = require("typeorm");
var ServiceType;
(function (ServiceType) {
    ServiceType["LOCAL"] = "local";
    ServiceType["STANDARD"] = "standard";
    ServiceType["LONG"] = "long";
    ServiceType["EXTENDED"] = "extended";
})(ServiceType || (exports.ServiceType = ServiceType = {}));
let Service = class Service {
};
exports.Service = Service;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], Service.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Service.prototype, "name", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'text', nullable: true }),
    __metadata("design:type", String)
], Service.prototype, "description", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'enum',
        enum: ServiceType,
    }),
    __metadata("design:type", String)
], Service.prototype, "type", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 8, scale: 2 }),
    __metadata("design:type", Number)
], Service.prototype, "smallPetPrice", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 8, scale: 2 }),
    __metadata("design:type", Number)
], Service.prototype, "mediumPetPrice", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 8, scale: 2 }),
    __metadata("design:type", Number)
], Service.prototype, "largePetPrice", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 8, scale: 2, default: 7.00 }),
    __metadata("design:type", Number)
], Service.prototype, "cratePrice", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 8, scale: 2, default: 5.00 }),
    __metadata("design:type", Number)
], Service.prototype, "medicationPrice", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 8, scale: 2, default: 15.00 }),
    __metadata("design:type", Number)
], Service.prototype, "waitReturnHourlyPrice", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 8, scale: 2, default: 10.00 }),
    __metadata("design:type", Number)
], Service.prototype, "specialTimePrice", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 3, scale: 2, default: 1.60 }),
    __metadata("design:type", Number)
], Service.prototype, "roundTripMultiplier", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: true }),
    __metadata("design:type", Boolean)
], Service.prototype, "isActive", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], Service.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], Service.prototype, "updatedAt", void 0);
exports.Service = Service = __decorate([
    (0, typeorm_1.Entity)('services')
], Service);
//# sourceMappingURL=service.entity.js.map