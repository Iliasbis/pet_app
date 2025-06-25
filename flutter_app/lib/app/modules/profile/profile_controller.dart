import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/app_constants.dart';
import '../../data/models/user_model.dart';
import '../../data/providers/api_provider.dart';
import '../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final SharedPreferences _prefs = Get.find<SharedPreferences>();

  final user = Rxn<UserModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.getProfile();
      print('Profile API response:');
      print(response.data);
      user.value = UserModel.fromJson(response.data);
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Error',
          message: 'Failed to load profile',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void editProfile() {
    Get.toNamed(AppRoutes.editProfile, arguments: user.value)?.then((_) {
      loadUserProfile();
    });
  }

  void logout() async {
    final confirmed = await Get.dialog<bool>(
          AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text('Logout'),
              ),
            ],
          ),
        ) ??
        false;

    if (confirmed) {
      await _prefs.remove(AppConstants.accessTokenKey);
      await _prefs.remove(AppConstants.userDataKey);
      await _prefs.setBool(AppConstants.isLoggedInKey, false);
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void goToSettings() {
    Get.toNamed(AppRoutes.settings);
  }

  void goToHelp() {
    Get.toNamed(AppRoutes.help);
  }

  void goToNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }

  void goToPayment() {
    Get.toNamed(AppRoutes.payment);
  }

  void goToAbout() {
    Get.toNamed(AppRoutes.about);
  }
}
