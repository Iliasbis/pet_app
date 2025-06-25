import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_constants.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/api_provider.dart';
import '../../../routes/app_routes.dart';

class RegisterController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final SharedPreferences _prefs = Get.find<SharedPreferences>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  late final GlobalKey<FormState> formKey;

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  RegisterController() {
    formKey = GlobalKey<FormState>(debugLabel: 'register-form-${UniqueKey()}');
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void register() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final response = await _apiProvider.register({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim().isEmpty
            ? null
            : phoneController.text.trim(),
        'address': addressController.text.trim().isEmpty
            ? null
            : addressController.text.trim(),
        'password': passwordController.text,
      });

      final userData = response.data;
      final user = UserModel.fromJson(userData['user']);
      final token = userData['access_token'];

      // Save user data and token
      await _prefs.setString(AppConstants.accessTokenKey, token);
      await _prefs.setString(
          AppConstants.userDataKey, user.toJson().toString());
      await _prefs.setBool(AppConstants.isLoggedInKey, true);

      Get.showSnackbar(
        const GetSnackBar(
          title: 'Success',
          message: AppConstants.registrationSuccessMessage,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      Get.offNamed(AppRoutes.home);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Registration Failed',
          message: e.toString().contains('409')
              ? 'Email already exists'
              : 'Registration failed. Please try again.',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.back();
  }

  String? validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.length > AppConstants.maxNameLength) {
      return '$fieldName must be less than ${AppConstants.maxNameLength} characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(AppConstants.emailPattern).hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(AppConstants.phonePattern).hasMatch(value)) {
        return 'Please enter a valid phone number';
      }
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
