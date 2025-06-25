import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../data/models/pet_model.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import 'add_pet_controller.dart';

class AddPetView extends GetView<AddPetController> {
  const AddPetView({super.key});

  @override
  Widget build(BuildContext context) {
    final isEditing = controller.editingPet != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Pet' : 'Add Pet'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [AppColors.primaryTurquoise, Colors.white],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(context, isEditing),

                  const SizedBox(height: 24),

                  // Basic Information
                  _buildBasicInfoSection(context),

                  const SizedBox(height: 24),

                  // Pet Size Selection
                  _buildSizeSelection(context),

                  const SizedBox(height: 24),

                  // Additional Information
                  _buildAdditionalInfoSection(context),

                  const SizedBox(height: 24),

                  // Veterinary Information
                  _buildVetInfoSection(context),

                  const SizedBox(height: 24),

                  // Emergency Contact
                  _buildEmergencyContactSection(context),

                  const SizedBox(height: 32),

                  // Save Button
                  Obx(() => CustomButton(
                        text: isEditing ? 'Update Pet' : 'Add Pet',
                        onPressed: controller.savePet,
                        isLoading: controller.isLoading.value,
                        gradient: AppColors.primaryGradient,
                      )),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isEditing) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryTurquoise.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text('🐾', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEditing ? 'Edit Pet Information' : 'Add New Pet',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  isEditing
                      ? 'Update your pet\'s details'
                      : 'Tell us about your furry friend',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Basic Information',
      icon: Icons.pets,
      children: [
        CustomTextField(
          controller: controller.nameController,
          label: 'Pet Name *',
          hintText: 'e.g., Buddy',
          prefixIcon: Icons.pets,
          validator: controller.validateName,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.breedController,
          label: 'Breed *',
          hintText: 'e.g., Golden Retriever',
          prefixIcon: Icons.category,
          validator: controller.validateBreed,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: controller.ageController,
                label: 'Age (years) *',
                hintText: '3',
                prefixIcon: Icons.cake,
                keyboardType: TextInputType.number,
                validator: controller.validateAge,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                controller: controller.weightController,
                label: 'Weight (lbs) *',
                hintText: '45.5',
                prefixIcon: Icons.monitor_weight,
                keyboardType: TextInputType.number,
                validator: controller.validateWeight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.colorController,
          label: 'Color',
          hintText: 'e.g., Brown and White',
          prefixIcon: Icons.palette,
        ),
      ],
    );
  }

  Widget _buildSizeSelection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Pet Size',
      icon: Icons.straighten,
      children: [
        Text(
          'Select your pet\'s size category:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 12),
        Obx(() => Row(
              children: PetSize.values.map((size) {
                final isSelected = controller.selectedSize.value == size;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectSize(size),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryTurquoise
                            : AppColors.neutral200,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryTurquoise
                              : AppColors.neutral300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _getSizeEmoji(size),
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getSizeName(size),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            _getSizeDescription(size),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: isSelected
                                      ? Colors.white.withOpacity(0.8)
                                      : AppColors.textSecondary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget _buildAdditionalInfoSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Additional Information',
      icon: Icons.info_outline,
      children: [
        CustomTextField(
          controller: controller.behaviorNotesController,
          label: 'Behavior Notes',
          hintText: 'e.g., Friendly but shy with strangers',
          prefixIcon: Icons.psychology,
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.medicalNotesController,
          label: 'Medical Notes',
          hintText: 'e.g., Allergic to chicken, takes medication',
          prefixIcon: Icons.medical_services,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildVetInfoSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Veterinary Information',
      icon: Icons.local_hospital,
      children: [
        CustomTextField(
          controller: controller.vetNameController,
          label: 'Veterinarian Name',
          hintText: 'Dr. Smith',
          prefixIcon: Icons.person,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.vetPhoneController,
          label: 'Vet Phone Number',
          hintText: '+1 (555) 123-4567',
          prefixIcon: Icons.phone,
          keyboardType: TextInputType.phone,
          validator: controller.validatePhone,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.vetAddressController,
          label: 'Vet Address',
          hintText: '123 Vet St, City, State',
          prefixIcon: Icons.location_on,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildEmergencyContactSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Emergency Contact',
      icon: Icons.emergency,
      children: [
        CustomTextField(
          controller: controller.emergencyContactController,
          label: 'Emergency Contact Name',
          hintText: 'Jane Doe',
          prefixIcon: Icons.contact_emergency,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.emergencyPhoneController,
          label: 'Emergency Phone Number',
          hintText: '+1 (555) 987-6543',
          prefixIcon: Icons.phone_in_talk,
          keyboardType: TextInputType.phone,
          validator: controller.validatePhone,
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryTurquoise),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  String _getSizeEmoji(PetSize size) {
    switch (size) {
      case PetSize.small:
        return '🐱';
      case PetSize.medium:
        return '🐶';
      case PetSize.large:
        return '🐕';
    }
  }

  String _getSizeName(PetSize size) {
    switch (size) {
      case PetSize.small:
        return 'Small';
      case PetSize.medium:
        return 'Medium';
      case PetSize.large:
        return 'Large';
    }
  }

  String _getSizeDescription(PetSize size) {
    switch (size) {
      case PetSize.small:
        return 'Under 25 lbs';
      case PetSize.medium:
        return '25-60 lbs';
      case PetSize.large:
        return 'Over 60 lbs';
    }
  }
}
