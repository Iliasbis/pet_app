import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'edit_profile_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class EditProfileView extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      controller: controller.firstNameController,
                      label: 'First Name',
                      prefixIcon: Icons.person_outline,
                      validator: controller.validateName,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.lastNameController,
                      label: 'Last Name',
                      prefixIcon: Icons.person_outline,
                      validator: controller.validateName,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.emailController,
                      label: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: controller.validateEmail,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.phoneController,
                      label: 'Phone',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.addressController,
                      label: 'Address',
                      prefixIcon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: 32),
                    CustomButton(
                      text: 'Save Changes',
                      onPressed: controller.updateProfile,
                      isLoading: controller.isLoading.value,
                      gradient: AppColors.primaryGradient,
                    ),
                  ],
                ),
              ),
            )),
    );
  }
}
