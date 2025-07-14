import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_constants.dart';
import '../../../data/models/driver_model.dart';
import '../../../data/providers/api_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../services/socket_service.dart';

class LoginController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final SocketService _socketService = Get.find<SocketService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final GlobalKey<FormState> formKey;

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  LoginController() {
    formKey = GlobalKey<FormState>(debugLabel: 'login-form-${UniqueKey()}');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      final response = await _apiProvider.login({
        'email': emailController.text.trim(),
        'password': passwordController.text,
      });

      final userData = response.data;
      final driver = DriverModel.fromJson(userData['driver']);
      final token = userData['access_token'];

      await _prefs.setString(AppConstants.accessTokenKey, token);
      await _prefs.setString(AppConstants.driverDataKey, driver.toJson().toString());
      await _prefs.setBool(AppConstants.isLoggedInKey, true);

      // Connect to socket
      _socketService.connect();

      Get.showSnackbar(
        const GetSnackBar(
          title: 'Success',
          message: AppConstants.loginSuccessMessage,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      print('Login error: $e');
      Get.showSnackbar(
        GetSnackBar(
          title: 'Login Failed',
          message: e.toString().contains('401')
              ? 'Invalid email or password'
              : 'Login failed. Please try again.',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.register);
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    return null;
  }
}