import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.largePadding),
            child: Column(
              children: [
                const SizedBox(height: 60),
                
                // Logo and Welcome
                _buildHeader(context),
                
                const SizedBox(height: 60),
                
                // Login Form
                _buildLoginForm(context),
                
                const SizedBox(height: 40),
                
                // Register Link
                _buildRegisterLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Text('🚗🐾', style: TextStyle(fontSize: 32)),
          ),
        ),
        
        const SizedBox(height: 24),
        
        Text(
          'Driver Login',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          'Sign in to your ${AppConstants.driverAppName} account',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: controller.emailController,
              label: 'Email Address',
              hintText: 'Enter your email',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: controller.validateEmail,
            ),
            
            const SizedBox(height: 20),
            
            Obx(() => CustomTextField(
              controller: controller.passwordController,
              label: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icons.lock_outline,
              obscureText: !controller.isPasswordVisible.value,
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                ),
                onPressed: controller.togglePasswordVisibility,
              ),
              validator: controller.validatePassword,
            )),
            
            const SizedBox(height: 32),
            
            Obx(() => CustomButton(
              text: 'Sign In',
              onPressed: controller.login,
              isLoading: controller.isLoading.value,
              gradient: AppColors.primaryGradient,
            )),
            
            const SizedBox(height: 16),
            
            TextButton(
              onPressed: () {
                // TODO: Implement forgot password
              },
              child: Text(
                'Forgot Password?',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.primaryTurquoise,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        GestureDetector(
          onTap: controller.goToRegister,
          child: Text(
            'Sign Up',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}