import { Controller, Get, Post, Body, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { LoyaltyService } from './loyalty.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Loyalty')
@Controller('loyalty')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class LoyaltyController {
  constructor(private readonly loyaltyService: LoyaltyService) {}

  @Get()
  @ApiOperation({ summary: 'Get user loyalty data' })
  @ApiResponse({ status: 200, description: 'Loyalty data retrieved successfully' })
  getLoyaltyData(@Request() req) {
    return this.loyaltyService.getLoyaltyData(req.user.id);
  }

  @Get('rewards')
  @ApiOperation({ summary: 'Get available rewards' })
  @ApiResponse({ status: 200, description: 'Rewards retrieved successfully' })
  getRewards() {
    return this.loyaltyService.getRewards();
  }

  @Post('redeem')
  @ApiOperation({ summary: 'Redeem loyalty points' })
  @ApiResponse({ status: 200, description: 'Points redeemed successfully' })
  redeemPoints(@Request() req, @Body() body: { points: number; description: string }) {
    return this.loyaltyService.redeemPoints(req.user.id, body.points, body.description);
  }

  @Post('referral')
  @ApiOperation({ summary: 'Process referral code' })
  @ApiResponse({ status: 200, description: 'Referral processed successfully' })
  processReferral(@Request() req, @Body() body: { referralCode: string }) {
    return this.loyaltyService.processReferral(body.referralCode, req.user.id);
  }
}