import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/app_constants.dart';
import '../../data/models/user_model.dart';
import '../../data/providers/api_provider.dart';

class EditProfileController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final SharedPreferences _prefs = Get.find<SharedPreferences>();

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final isLoading = false.obs;

  UserModel? user;

  @override
  void onInit() {
    super.onInit();
    final argUser = Get.arguments as UserModel?;
    if (argUser != null) {
      user = argUser;
      firstNameController.text = user!.firstName;
      lastNameController.text = user!.lastName;
      emailController.text = user!.email;
      phoneController.text = user!.phone ?? '';
      addressController.text = user!.address ?? '';
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;
    try {
      isLoading.value = true;
      final data = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'address': addressController.text.trim(),
      };
      final response = await _apiProvider.updateProfile(data);
      final updatedUser = UserModel.fromJson(response.data);
      // Save updated user in prefs
      await _prefs.setString(
          AppConstants.userDataKey, updatedUser.toJson().toString());
      Get.back(result: updatedUser);
      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Profile updated successfully!',
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: 'Failed to update profile',
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ));
    } finally {
      isLoading.value = false;
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!RegExp(AppConstants.emailPattern).hasMatch(value))
      return 'Invalid email';
    return null;
  }
}
