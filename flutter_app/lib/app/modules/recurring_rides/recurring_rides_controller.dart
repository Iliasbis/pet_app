import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/recurring_ride_model.dart';
import '../../data/providers/api_provider.dart';

class RecurringRidesController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  final recurringRides = <RecurringRideModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadRecurringRides();
  }

  Future<void> loadRecurringRides() async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.getRecurringRides();
      final rideList = (response.data as List)
          .map((json) => RecurringRideModel.fromJson(json))
          .toList();
      recurringRides.value = rideList;
    } catch (e) {
      print('Error loading recurring rides: $e');
      Get.snackbar(
        'Error',
        'Failed to load recurring rides',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleRecurringRide(String rideId, bool isActive) async {
    try {
      await _apiProvider.updateRecurringRide(rideId, {'isActive': isActive});
      
      // Update local data
      final index = recurringRides.indexWhere((ride) => ride.id == rideId);
      if (index != -1) {
        recurringRides[index] = recurringRides[index].copyWith(isActive: isActive);
        recurringRides.refresh();
      }
      
      Get.snackbar(
        'Success',
        isActive ? 'Recurring ride activated' : 'Recurring ride paused',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update recurring ride',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> deleteRecurringRide(String rideId) async {
    try {
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Delete Recurring Ride'),
          content: const Text('Are you sure you want to delete this recurring ride?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Delete'),
            ),
          ],
        ),
      ) ?? false;

      if (confirmed) {
        await _apiProvider.deleteRecurringRide(rideId);
        recurringRides.removeWhere((ride) => ride.id == rideId);
        
        Get.snackbar(
          'Success',
          'Recurring ride deleted successfully',
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete recurring ride',
        backgroundColor: Colors.red,
      );
    }
  }

  void createRecurringRide() {
    Get.toNamed('/create-recurring-ride');
  }

  void editRecurringRide(RecurringRideModel ride) {
    Get.toNamed('/edit-recurring-ride', arguments: ride);
  }
}