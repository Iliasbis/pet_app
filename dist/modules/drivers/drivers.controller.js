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
exports.DriversController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const drivers_service_1 = require("./drivers.service");
const create_driver_dto_1 = require("./dto/create-driver.dto");
const update_driver_dto_1 = require("./dto/update-driver.dto");
const update_driver_status_dto_1 = require("./dto/update-driver-status.dto");
const update_location_dto_1 = require("./dto/update-location.dto");
const jwt_auth_guard_1 = require("../auth/guards/jwt-auth.guard");
let DriversController = class DriversController {
    constructor(driversService) {
        this.driversService = driversService;
    }
    create(createDriverDto) {
        return this.driversService.create(createDriverDto);
    }
    findAll() {
        return this.driversService.findAll();
    }
    findAvailable() {
        return this.driversService.findAvailableDrivers();
    }
    getProfile(req) {
        return this.driversService.findById(req.user.id);
    }
    getStats(req) {
        return this.driversService.getDriverStats(req.user.id);
    }
    findOne(id) {
        return this.driversService.findById(id);
    }
    updateProfile(req, updateDriverDto) {
        return this.driversService.update(req.user.id, updateDriverDto);
    }
    updateStatus(req, updateStatusDto) {
        return this.driversService.updateStatus(req.user.id, updateStatusDto.status);
    }
    updateLocation(req, updateLocationDto) {
        return this.driversService.updateLocation(req.user.id, updateLocationDto.latitude, updateLocationDto.longitude);
    }
    update(id, updateDriverDto) {
        return this.driversService.update(id, updateDriverDto);
    }
    remove(id) {
        return this.driversService.remove(id);
    }
};
exports.DriversController = DriversController;
__decorate([
    (0, common_1.Post)(),
    (0, swagger_1.ApiOperation)({ summary: 'Create a new driver (Admin only)' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Driver created successfully' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_driver_dto_1.CreateDriverDto]),
    __metadata("design:returntype", void 0)
], DriversController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    (0, swagger_1.ApiOperation)({ summary: 'Get all drivers (Admin only)' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Drivers retrieved successfully' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], DriversController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)('available'),
    (0, swagger_1.ApiOperation)({ summary: 'Get available drivers' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Available drivers retrieved successfully' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], DriversController.prototype, "findAvailable", null);
__decorate([
    (0, common_1.Get)('me'),
    (0, swagger_1.ApiOperation)({ summary: 'Get current driver profile' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Driver profile retrieved successfully' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], DriversController.prototype, "getProfile", null);
__decorate([
    (0, common_1.Get)('me/stats'),
    (0, swagger_1.ApiOperation)({ summary: 'Get driver statistics' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Driver stats retrieved successfully' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], DriversController.prototype, "getStats", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get driver by ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Driver retrieved successfully' }),
    (0, swagger_1.ApiResponse)({ status: 404, description: 'Driver not found' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], DriversController.prototype, "findOne", null);
__decorate([
    (0, common_1.Patch)('me'),
    (0, swagger_1.ApiOperation)({ summary: 'Update current driver profile' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Driver profile updated successfully' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, update_driver_dto_1.UpdateDriverDto]),
    __metadata("design:returntype", void 0)
], DriversController.prototype, "updateProfile", null);
__decorate([
    (0, common_1.Patch)('me/status'),
    (0, swagger_1.ApiOperation)({ summary: 'Update driver status' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Driver status updated successfully' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, update_driver_status_dto_1.UpdateDriverStatusDto]),
    __metadata("design:returntype", void 0)
], DriversController.prototype, "updateStatus", null);
__decorate([
    (0, common_1.Patch)('me/location'),
    (0, swagger_1.ApiOperation)({ summary: 'Update driver location' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Driver location updated successfully' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, update_location_dto_1.UpdateLocationDto]),
    __metadata("design:returntype", void 0)
], DriversController.prototype, "updateLocation", null);
__decorate([
    (0, common_1.Patch)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Update driver by ID (Admin only)' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Driver updated successfully' }),
    (0, swagger_1.ApiResponse)({ status: 404, description: 'Driver not found' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_driver_dto_1.UpdateDriverDto]),
    __metadata("design:returntype", void 0)
], DriversController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete driver by ID (Admin only)' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Driver deleted successfully' }),
    (0, swagger_1.ApiResponse)({ status: 404, description: 'Driver not found' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], DriversController.prototype, "remove", null);
exports.DriversController = DriversController = __decorate([
    (0, swagger_1.ApiTags)('Drivers'),
    (0, common_1.Controller)('drivers'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [drivers_service_1.DriversService])
], DriversController);
//# sourceMappingURL=drivers.controller.js.map