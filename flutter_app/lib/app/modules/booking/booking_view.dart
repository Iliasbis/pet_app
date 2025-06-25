import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_constants.dart';
import '../../data/models/booking_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'booking_controller.dart';
import '../profile/profile_controller.dart';

class BookingView extends StatelessWidget {
  BookingView({super.key}) {
    // Manually inject both controllers as a workaround
    if (!Get.isRegistered<BookingController>()) {
      Get.put(BookingController());
    }
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Ride'),
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
          child: Obx(() {
            if (Get.find<BookingController>().isLoading.value &&
                Get.find<BookingController>().pets.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Form(
                key: Get.find<BookingController>().formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    _buildHeader(context),

                    const SizedBox(height: 24),

                    // Pet Selection
                    _buildPetSelection(context),

                    const SizedBox(height: 24),

                    // Service Selection
                    _buildServiceSelection(context),

                    const SizedBox(height: 24),

                    // Booking Type
                    _buildBookingTypeSelection(context),

                    const SizedBox(height: 24),

                    // Addresses
                    _buildAddressSection(context),

                    const SizedBox(height: 24),

                    // Date and Time
                    _buildDateTimeSection(context),

                    const SizedBox(height: 24),

                    // Add-ons
                    _buildAddOnsSection(context),

                    const SizedBox(height: 24),

                    // Special Instructions
                    _buildSpecialInstructionsSection(context),

                    const SizedBox(height: 24),

                    // Price Summary
                    _buildPriceSummary(context),

                    const SizedBox(height: 32),

                    // Book Button
                    Obx(() => CustomButton(
                          text:
                              'Book Ride - \$${Get.find<BookingController>().calculatedPrice.value.toStringAsFixed(2)}',
                          onPressed:
                              Get.find<BookingController>().createBooking,
                          isLoading:
                              Get.find<BookingController>().isLoading.value,
                          gradient: AppColors.primaryGradient,
                        )),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
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
              color: AppColors.primaryTurquoise.withAlpha((0.1 * 255).toInt()),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text('🚗', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book a Ride',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'Safe and reliable pet transportation',
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

  Widget _buildPetSelection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Select Pet',
      icon: Icons.pets,
      child: Obx(() {
        if (Get.find<BookingController>().pets.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.warning.withAlpha((0.1 * 255).toInt()),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: AppColors.warning.withAlpha((0.3 * 255).toInt())),
            ),
            child: Column(
              children: [
                const Icon(Icons.pets, size: 32, color: AppColors.warning),
                const SizedBox(height: 8),
                Text(
                  'No pets found',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Please add a pet first before booking',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'Add Pet',
                  size: ButtonSize.small,
                  backgroundColor: AppColors.warning,
                  onPressed: () => Get.toNamed('/add-pet'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: Get.find<BookingController>().pets.map((pet) {
            final isSelected =
                Get.find<BookingController>().selectedPet.value?.id == pet.id;
            return GestureDetector(
              onTap: () => Get.find<BookingController>().selectPet(pet),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryTurquoise
                          .withAlpha((0.1 * 255).toInt())
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryTurquoise
                        : AppColors.neutral300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Hero(
                      tag: 'pet-avatar-${pet.id}-booking',
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primaryTurquoise
                              .withAlpha((0.1 * 255).toInt()),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(pet.petEmoji,
                              style: const TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pet.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            '${pet.breed} • ${pet.sizeDisplayName}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle,
                          color: AppColors.primaryTurquoise),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }

  Widget _buildServiceSelection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Select Service',
      icon: Icons.local_shipping,
      child: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: Get.find<BookingController>().services.map((service) {
                final isSelected =
                    Get.find<BookingController>().selectedService.value?.id ==
                        service.id;
                return Container(
                  width: 260,
                  margin: const EdgeInsets.only(right: 12, bottom: 12),
                  child: GestureDetector(
                    onTap: () =>
                        Get.find<BookingController>().selectService(service),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryTurquoise
                                .withAlpha((0.1 * 255).toInt())
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryTurquoise
                              : AppColors.neutral300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.primaryTurquoise
                                  .withAlpha((0.1 * 255).toInt()),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(service.typeEmoji,
                                  style: const TextStyle(fontSize: 20)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  service.typeDisplayName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                                if (Get.find<BookingController>()
                                        .selectedPet
                                        .value !=
                                    null)
                                  Text(
                                    'From \$${service.getPriceForPetSize(Get.find<BookingController>().selectedPet.value!.size).toStringAsFixed(2)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: AppColors.primaryTurquoise,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(Icons.check_circle,
                                color: AppColors.primaryTurquoise),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )),
    );
  }

  Widget _buildBookingTypeSelection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Trip Type',
      icon: Icons.compare_arrows,
      child: Obx(() => Row(
            children: BookingType.values.map((type) {
              final isSelected =
                  Get.find<BookingController>().bookingType.value == type;
              return Expanded(
                child: GestureDetector(
                  onTap: () =>
                      Get.find<BookingController>().selectBookingType(type),
                  child: Container(
                    margin: EdgeInsets.only(
                        right: type == BookingType.oneWay ? 8 : 0),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryTurquoise
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryTurquoise
                            : AppColors.neutral300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          type == BookingType.oneWay
                              ? Icons.arrow_forward
                              : Icons.sync_alt,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textSecondary,
                          size: 24,
                        ),
                        SizedBox(height: 8),
                        Text(
                          type == BookingType.oneWay ? 'One Way' : 'Round Trip',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          type == BookingType.oneWay
                              ? 'Single trip'
                              : '+60% of base price',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                            .withAlpha((0.8 * 255).toInt())
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
    );
  }

  Widget _buildAddressSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Addresses',
      icon: Icons.location_on,
      child: Column(
        children: [
          CustomTextField(
            controller: Get.find<BookingController>().pickupAddressController,
            label: 'Pickup Address *',
            hintText: '123 Main St, City, State 12345',
            prefixIcon: Icons.my_location,
            validator: Get.find<BookingController>().validateAddress,
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: Get.find<BookingController>().dropOffAddressController,
            label: 'Drop-off Address *',
            hintText: '456 Oak Ave, City, State 12345',
            prefixIcon: Icons.location_on,
            validator: Get.find<BookingController>().validateAddress,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Date & Time',
      icon: Icons.schedule,
      child: Obx(() => Column(
            children: [
              // Pickup Date & Time
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: Get.find<BookingController>().selectDate,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.neutral300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pickup Date *',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              Get.find<BookingController>()
                                          .selectedDate
                                          .value !=
                                      null
                                  ? DateFormat('MMM dd, yyyy').format(
                                      Get.find<BookingController>()
                                          .selectedDate
                                          .value!)
                                  : 'Select date',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Get.find<BookingController>()
                                                .selectedDate
                                                .value !=
                                            null
                                        ? AppColors.textPrimary
                                        : AppColors.textTertiary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: Get.find<BookingController>().selectTime,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.neutral300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pickup Time *',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              Get.find<BookingController>()
                                          .selectedTime
                                          .value !=
                                      null
                                  ? Get.find<BookingController>()
                                      .selectedTime
                                      .value!
                                      .format(context)
                                  : 'Select time',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Get.find<BookingController>()
                                                .selectedTime
                                                .value !=
                                            null
                                        ? AppColors.textPrimary
                                        : AppColors.textTertiary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Round Trip Drop-off Date & Time
              if (Get.find<BookingController>().bookingType.value ==
                  BookingType.roundTrip) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: Get.find<BookingController>().selectDropOffDate,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.neutral300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Return Date *',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                Get.find<BookingController>()
                                            .dropOffDate
                                            .value !=
                                        null
                                    ? DateFormat('MMM dd, yyyy').format(
                                        Get.find<BookingController>()
                                            .dropOffDate
                                            .value!)
                                    : 'Select date',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Get.find<BookingController>()
                                                  .dropOffDate
                                                  .value !=
                                              null
                                          ? AppColors.textPrimary
                                          : AppColors.textTertiary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: Get.find<BookingController>().selectDropOffTime,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.neutral300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Return Time *',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                Get.find<BookingController>()
                                            .dropOffTime
                                            .value !=
                                        null
                                    ? Get.find<BookingController>()
                                        .dropOffTime
                                        .value!
                                        .format(context)
                                    : 'Select time',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Get.find<BookingController>()
                                                  .dropOffTime
                                                  .value !=
                                              null
                                          ? AppColors.textPrimary
                                          : AppColors.textTertiary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          )),
    );
  }

  Widget _buildAddOnsSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Add-ons',
      icon: Icons.add_circle_outline,
      child: Obx(() => Column(
            children: [
              // Crate
              _buildAddOnTile(
                context,
                title: 'Pet Crate',
                subtitle: 'Secure transportation crate (+\$7.00)',
                icon: Icons.inventory_2,
                value: Get.find<BookingController>().needsCrate.value,
                onChanged: (_) => Get.find<BookingController>().toggleCrate(),
              ),

              const SizedBox(height: 12),

              // Medication
              _buildAddOnTile(
                context,
                title: 'Medication Administration',
                subtitle: 'Give medication during transport (+\$5.00)',
                icon: Icons.medical_services,
                value: Get.find<BookingController>().needsMedication.value,
                onChanged: (_) =>
                    Get.find<BookingController>().toggleMedication(),
              ),

              const SizedBox(height: 12),

              // Wait & Return Hours
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.neutral300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            color: AppColors.textSecondary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wait & Return',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                'Wait at destination and return (+\$15.00/hour)',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Hours: ${Get.find<BookingController>().waitReturnHours.value}',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: Get.find<BookingController>()
                                      .waitReturnHours
                                      .value >
                                  0
                              ? () => Get.find<BookingController>()
                                  .updateWaitReturnHours(
                                      Get.find<BookingController>()
                                              .waitReturnHours
                                              .value -
                                          1)
                              : null,
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        IconButton(
                          onPressed: () => Get.find<BookingController>()
                              .updateWaitReturnHours(
                                  Get.find<BookingController>()
                                          .waitReturnHours
                                          .value +
                                      1),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Special Time
              _buildAddOnTile(
                context,
                title: 'Early/Late/Holiday Service',
                subtitle: 'Service outside normal hours (+\$10.00)',
                icon: Icons.schedule,
                value: Get.find<BookingController>().isSpecialTime.value,
                onChanged: (_) =>
                    Get.find<BookingController>().toggleSpecialTime(),
              ),
            ],
          )),
    );
  }

  Widget _buildAddOnTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: value
            ? AppColors.primaryTurquoise.withAlpha((0.1 * 255).toInt())
            : AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? AppColors.primaryTurquoise : AppColors.neutral300,
          width: value ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon,
              color:
                  value ? AppColors.primaryTurquoise : AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: value
                            ? AppColors.primaryTurquoise
                            : AppColors.textPrimary,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: value
                            ? AppColors.primaryTurquoise
                            : AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryTurquoise,
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialInstructionsSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Special Instructions',
      icon: Icons.note,
      child: CustomTextField(
        controller: Get.find<BookingController>().specialInstructionsController,
        hintText: 'Any special instructions for the driver...',
        maxLines: 3,
      ),
    );
  }

  Widget _buildPriceSummary(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
            boxShadow: [
              BoxShadow(
                color:
                    AppColors.primaryTurquoise.withAlpha((0.3 * 255).toInt()),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.receipt, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Price Summary',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (Get.find<BookingController>().isCalculatingPrice.value)
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              else if (Get.find<BookingController>().calculatedPrice.value >
                  0) ...[
                _buildPriceRow(
                    context,
                    'Service',
                    Get.find<BookingController>().selectedService.value?.name ??
                        ''),
                _buildPriceRow(
                    context,
                    'Pet',
                    Get.find<BookingController>().selectedPet.value?.name ??
                        ''),
                _buildPriceRow(context, 'Trip Type',
                    Get.find<BookingController>().bookingType.value.name),
                if (Get.find<BookingController>().needsCrate.value)
                  _buildPriceRow(context, 'Crate', '+\$7.00'),
                if (Get.find<BookingController>().needsMedication.value)
                  _buildPriceRow(context, 'Medication', '+\$5.00'),
                if (Get.find<BookingController>().waitReturnHours.value > 0)
                  _buildPriceRow(context, 'Wait & Return',
                      '+\$${(Get.find<BookingController>().waitReturnHours.value * 15).toStringAsFixed(2)}'),
                if (Get.find<BookingController>().isSpecialTime.value)
                  _buildPriceRow(context, 'Special Time', '+\$10.00'),
                const Divider(color: Colors.white54, height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      '\$${Get.find<BookingController>().calculatedPrice.value.toStringAsFixed(2)}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ] else
                Center(
                  child: Text(
                    'Select pet and service to see price',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withAlpha((0.8 * 255).toInt()),
                        ),
                  ),
                ),
            ],
          ),
        ));
  }

  Widget _buildPriceRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withAlpha((0.9 * 255).toInt()),
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
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
          child,
        ],
      ),
    );
  }
}
