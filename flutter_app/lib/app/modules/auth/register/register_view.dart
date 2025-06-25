import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
                const SizedBox(height: 40),
                
                // Header
                _buildHeader(context),
                
                const SizedBox(height: 40),
                
                // Registration Form
                _buildRegistrationForm(context),
                
                const SizedBox(height: 30),
                
                // Login Link
                _buildLoginLink(context),
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
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Text('🌴🐾', style: TextStyle(fontSize: 24)),
          ),
        ),
        
        const SizedBox(height: 20),
        
        Text(
          'Create Account',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        Text(
          'Join ${AppConstants.appName} today',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
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
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.firstNameController,
                    label: 'First Name',
                    hintText: 'John',
                    prefixIcon: Icons.person_outline,
                    validator: (value) => controller.validateName(value, 'First name'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    controller: controller.lastNameController,
                    label: 'Last Name',
                    hintText: 'Doe',
                    prefixIcon: Icons.person_outline,
                    validator: (value) => controller.validateName(value, 'Last name'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            CustomTextField(
              controller: controller.emailController,
              label: 'Email Address',
              hintText: 'john@example.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: controller.validateEmail,
            ),
            
            const SizedBox(height: 20),
            
            CustomTextField(
              controller: controller.phoneController,
              label: 'Phone Number (Optional)',
              hintText: '+1 (555) 123-4567',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: controller.validatePhone,
            ),
            
            const SizedBox(height: 20),
            
            CustomTextField(
              controller: controller.addressController,
              label: 'Address (Optional)',
              hintText: '123 Main St, City, State',
              prefixIcon: Icons.location_on_outlined,
              maxLines: 2,
            ),
            
            const SizedBox(height: 20),
            
            Obx(() => CustomTextField(
              controller: controller.passwordController,
              label: 'Password',
              hintText: 'Create a password',
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
            
            const SizedBox(height: 20),
            
            Obx(() => CustomTextField(
              controller: controller.confirmPasswordController,
              label: 'Confirm Password',
              hintText: 'Confirm your password',
              prefixIcon: Icons.lock_outline,
              obscureText: !controller.isConfirmPasswordVisible.value,
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isConfirmPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                ),
                onPressed: controller.toggleConfirmPasswordVisibility,
              ),
              validator: controller.validateConfirmPassword,
            )),
            
            const SizedBox(height: 32),
            
            Obx(() => CustomButton(
              text: 'Create Account',
              onPressed: controller.register,
              isLoading: controller.isLoading.value,
              gradient: AppColors.primaryGradient,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        GestureDetector(
          onTap: controller.goToLogin,
          child: Text(
            'Sign In',
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