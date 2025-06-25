import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/booking_model.dart';
import '../../data/providers/api_provider.dart';

class BookingsController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  final bookings = <BookingModel>[].obs;
  final isLoading = false.obs;
  final selectedFilter = BookingStatus.pending.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookings();
  }

  List<BookingModel> get filteredBookings {
    return bookings
        .where((booking) => booking.status == selectedFilter.value)
        .toList();
  }

  void changeFilter(BookingStatus status) {
    selectedFilter.value = status;
  }

  Future<void> loadBookings() async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.getBookings();
      final bookingList = (response.data as List)
          .map((json) => BookingModel.fromJson(json))
          .toList();
      bookings.value = bookingList;
    } catch (e) {
      print('Error loading bookings: $e');
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: 'Failed to load bookings: \n$e',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void viewBookingDetails(BookingModel booking) {
    Get.toNamed('/booking-details', arguments: booking);
  }

  Future<void> cancelBooking(BookingModel booking) async {
    try {
      final confirmed = await Get.dialog<bool>(
            AlertDialog(
              title: const Text('Cancel Booking'),
              content:
                  const Text('Are you sure you want to cancel this booking?'),
              actions: [
                TextButton(
                  onPressed: () => Get.back(result: false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Get.back(result: true),
                  child: const Text('Yes, Cancel'),
                ),
              ],
            ),
          ) ??
          false;

      if (confirmed) {
        await _apiProvider.cancelBooking(booking.id);
        bookings.removeWhere((b) => b.id == booking.id);
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Success',
            message: 'Booking cancelled successfully',
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Error',
          message: 'Failed to cancel booking',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
