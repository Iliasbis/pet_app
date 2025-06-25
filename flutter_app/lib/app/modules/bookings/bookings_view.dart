import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_constants.dart';
import '../../data/models/booking_model.dart';
import '../../widgets/custom_button.dart';
import 'bookings_controller.dart';

class BookingsView extends StatelessWidget {
  final bool isTab;

  BookingsView({super.key, this.isTab = false}) {
    // Ensure BookingsController is always available
    if (!Get.isRegistered<BookingsController>()) {
      Get.put(BookingsController(), permanent: true);
    }
  }

  BookingsController get controller {
    // Fallback mechanism to ensure controller is available
    if (!Get.isRegistered<BookingsController>()) {
      Get.put(BookingsController(), permanent: true);
    }
    return Get.find<BookingsController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isTab
          ? null
          : AppBar(
              title: const Text('My Bookings'),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isTab
              ? null
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [AppColors.primaryTurquoise, Colors.white],
                  stops: [0.0, 0.3],
                ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (isTab) _buildTabHeader(context),

              // Filter Tabs
              _buildFilterTabs(context),

              // Bookings List
              Expanded(
                child: _buildBookingsList(context),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed('/booking'),
        backgroundColor: AppColors.primaryTurquoise,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New Booking'),
        heroTag: 'bookings-fab',
      ),
    );
  }

  Widget _buildTabHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Bookings',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Track your pet transportation',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: BookingStatus.values.map((status) {
                final isSelected = controller.selectedFilter.value == status;
                return GestureDetector(
                  onTap: () => controller.changeFilter(status),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryTurquoise
                          : Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(AppConstants.borderRadius),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _getStatusEmoji(status),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _getStatusDisplayName(status),
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          )),
    );
  }

  Widget _buildBookingsList(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final bookings = controller.filteredBookings;

      if (bookings.isEmpty) {
        return _buildEmptyState(context);
      }

      return RefreshIndicator(
        onRefresh: controller.loadBookings,
        child: ListView.builder(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return _buildBookingCard(context, booking);
          },
        ),
      );
    });
  }

  Widget _buildBookingCard(BuildContext context, BookingModel booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
          onTap: () => controller.viewBookingDetails(booking),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with status
                Row(
                  children: [
                    Hero(
                      tag: 'booking-hero-${booking.id}-bookings',
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color:
                              _getStatusColor(booking.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              booking.statusEmoji,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              booking.statusDisplayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: _getStatusColor(booking.status),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${booking.totalPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryTurquoise,
                          ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Pet and service info
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primaryTurquoise.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          booking.pet?.petEmoji ?? '🐾',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.pet?.name ?? 'Unknown Pet',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            booking.service?.name ?? 'Unknown Service',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Addresses
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                          Text(
                            booking.pickupAddress,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'To',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                          Text(
                            booking.dropOffAddress,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Date and actions
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('MMM dd, yyyy')
                                .format(booking.pickupDate),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            booking.pickupTime,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    if (booking.status == BookingStatus.pending) ...[
                      CustomButton(
                        text: 'Cancel',
                        size: ButtonSize.small,
                        backgroundColor: AppColors.error,
                        onPressed: () => controller.cancelBooking(booking),
                      ),
                      const SizedBox(width: 8),
                    ],
                    CustomButton(
                      text: 'View Details',
                      size: ButtonSize.small,
                      backgroundColor: AppColors.primaryTurquoise,
                      onPressed: () => controller.viewBookingDetails(booking),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.largePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getEmptyStateEmoji(),
              style: const TextStyle(fontSize: 64),
            ),
            const SizedBox(height: 24),
            Text(
              _getEmptyStateTitle(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              _getEmptyStateMessage(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Book Your First Ride',
              gradient: AppColors.primaryGradient,
              onPressed: () => Get.toNamed('/booking'),
            ),
          ],
        ),
      ),
    );
  }

  String _getEmptyStateEmoji() {
    switch (controller.selectedFilter.value) {
      case BookingStatus.pending:
        return '⏳';
      case BookingStatus.confirmed:
        return '✅';
      case BookingStatus.inProgress:
        return '🚗';
      case BookingStatus.completed:
        return '🎉';
      case BookingStatus.cancelled:
        return '❌';
    }
  }

  String _getEmptyStateTitle() {
    switch (controller.selectedFilter.value) {
      case BookingStatus.pending:
        return 'No pending bookings';
      case BookingStatus.confirmed:
        return 'No confirmed bookings';
      case BookingStatus.inProgress:
        return 'No rides in progress';
      case BookingStatus.completed:
        return 'No completed rides';
      case BookingStatus.cancelled:
        return 'No cancelled bookings';
    }
  }

  String _getEmptyStateMessage() {
    switch (controller.selectedFilter.value) {
      case BookingStatus.pending:
        return 'You don\'t have any pending bookings at the moment.';
      case BookingStatus.confirmed:
        return 'No confirmed bookings yet. Book a ride to get started!';
      case BookingStatus.inProgress:
        return 'No rides currently in progress.';
      case BookingStatus.completed:
        return 'No completed rides yet. Your ride history will appear here.';
      case BookingStatus.cancelled:
        return 'No cancelled bookings.';
    }
  }

  String _getStatusEmoji(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return '⏳';
      case BookingStatus.confirmed:
        return '✅';
      case BookingStatus.inProgress:
        return '🚗';
      case BookingStatus.completed:
        return '🎉';
      case BookingStatus.cancelled:
        return '❌';
    }
  }

  String _getStatusDisplayName(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.inProgress:
        return 'In Progress';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return AppColors.warning;
      case BookingStatus.confirmed:
        return AppColors.info;
      case BookingStatus.inProgress:
        return AppColors.primaryTurquoise;
      case BookingStatus.completed:
        return AppColors.success;
      case BookingStatus.cancelled:
        return AppColors.error;
    }
  }
}
