import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/loyalty_model.dart';
import '../../data/providers/api_provider.dart';

class LoyaltyController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  final loyaltyData = Rxn<LoyaltyModel>();
  final referralCode = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoyaltyData();
  }

  Future<void> loadLoyaltyData() async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.getLoyaltyData();
      loyaltyData.value = LoyaltyModel.fromJson(response.data);
      referralCode.value = loyaltyData.value?.referralCode ?? '';
    } catch (e) {
      print('Error loading loyalty data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> redeemPoints(int points) async {
    try {
      isLoading.value = true;
      await _apiProvider.redeemLoyaltyPoints(points);
      await loadLoyaltyData(); // Refresh data
      
      Get.snackbar(
        'Success',
        'Points redeemed successfully!',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to redeem points',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void shareReferralCode() {
    // Implement share functionality
    Get.snackbar(
      'Referral Code',
      'Your referral code: ${referralCode.value}',
      backgroundColor: AppColors.info,
    );
  }

  String get pointsToNextReward {
    if (loyaltyData.value == null) return '0';
    final nextTier = loyaltyData.value!.nextTierPoints;
    final current = loyaltyData.value!.currentPoints;
    return (nextTier - current).toString();
  }

  double get progressToNextReward {
    if (loyaltyData.value == null) return 0.0;
    final nextTier = loyaltyData.value!.nextTierPoints;
    final current = loyaltyData.value!.currentPoints;
    final previous = loyaltyData.value!.currentTierPoints;
    
    if (nextTier == previous) return 1.0;
    return (current - previous) / (nextTier - previous);
  }
}