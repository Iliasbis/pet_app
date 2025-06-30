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
exports.CreateServiceDto = void 0;
const class_validator_1 = require("class-validator");
const swagger_1 = require("@nestjs/swagger");
const service_entity_1 = require("../entities/service.entity");
class CreateServiceDto {
}
exports.CreateServiceDto = CreateServiceDto;
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'Local Pet Transport' }),
    (0, class_validator_1.IsString)(),
    (0, class_validator_1.IsNotEmpty)(),
    __metadata("design:type", String)
], CreateServiceDto.prototype, "name", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'Transportation within 15 miles', required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], CreateServiceDto.prototype, "description", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ enum: service_entity_1.ServiceType, example: service_entity_1.ServiceType.LOCAL }),
    (0, class_validator_1.IsEnum)(service_entity_1.ServiceType),
    __metadata("design:type", String)
], CreateServiceDto.prototype, "type", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 25.00, description: 'Base price for small pets' }),
    (0, class_validator_1.IsNumber)(),
    (0, class_validator_1.Min)(0),
    __metadata("design:type", Number)
], CreateServiceDto.prototype, "smallPetPrice", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 35.00, description: 'Base price for medium pets' }),
    (0, class_validator_1.IsNumber)(),
    (0, class_validator_1.Min)(0),
    __metadata("design:type", Number)
], CreateServiceDto.prototype, "mediumPetPrice", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 45.00, description: 'Base price for large pets' }),
    (0, class_validator_1.IsNumber)(),
    (0, class_validator_1.Min)(0),
    __metadata("design:type", Number)
], CreateServiceDto.prototype, "largePetPrice", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 7.00, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsNumber)(),
    (0, class_validator_1.Min)(0),
    __metadata("design:type", Number)
], CreateServiceDto.prototype, "cratePrice", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 5.00, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsNumber)(),
    (0, class_validator_1.Min)(0),
    __metadata("design:type", Number)
], CreateServiceDto.prototype, "medicationPrice", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 15.00, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsNumber)(),
    (0, class_validator_1.Min)(0),
    __metadata("design:type", Number)
], CreateServiceDto.prototype, "waitReturnHourlyPrice", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 10.00, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsNumber)(),
    (0, class_validator_1.Min)(0),
    __metadata("design:type", Number)
], CreateServiceDto.prototype, "specialTimePrice", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 1.60, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsNumber)(),
    (0, class_validator_1.Min)(1),
    __metadata("design:type", Number)
], CreateServiceDto.prototype, "roundTripMultiplier", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: true, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsBoolean)(),
    __metadata("design:type", Boolean)
], CreateServiceDto.prototype, "isActive", void 0);
//# sourceMappingURL=create-service.dto.js.map