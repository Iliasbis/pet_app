import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../core/utils/app_constants.dart';
import '../../data/models/booking_model.dart';
import '../../data/models/pet_model.dart';
import '../../data/models/service_model.dart';
import '../../data/providers/api_provider.dart';
import '../../routes/app_routes.dart';

class BookingController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  final formKey = GlobalKey<FormState>();
  final pickupAddressController = TextEditingController();
  final dropOffAddressController = TextEditingController();
  final specialInstructionsController = TextEditingController();

  final pets = <PetModel>[].obs;
  final services = <ServiceModel>[].obs;
  final selectedPet = Rxn<PetModel>();
  final selectedService = Rxn<ServiceModel>();
  final selectedDate = Rxn<DateTime>();
  final selectedTime = Rxn<TimeOfDay>();
  final dropOffDate = Rxn<DateTime>();
  final dropOffTime = Rxn<TimeOfDay>();
  final bookingType = BookingType.oneWay.obs;
  final needsCrate = false.obs;
  final needsMedication = false.obs;
  final waitReturnHours = 0.obs;
  final isSpecialTime = false.obs;
  final calculatedPrice = 0.0.obs;
  final isLoading = false.obs;
  final isCalculatingPrice = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  @override
  void onClose() {
    pickupAddressController.dispose();
    dropOffAddressController.dispose();
    specialInstructionsController.dispose();
    super.onClose();
  }

  Future<void> loadInitialData() async {
    try {
      isLoading.value = true;
      await Future.wait([
        loadPets(),
        loadServices(),
      ]);
    } catch (e) {
      print('Error loading initial data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPets() async {
    try {
      final response = await _apiProvider.getPets();
      final petList = (response.data as List)
          .map((json) => PetModel.fromJson(json))
          .toList();
      pets.value = petList;
    } catch (e) {
      print('Error loading pets: $e');
    }
  }

  Future<void> loadServices() async {
    try {
      final response = await _apiProvider.getServices();
      final serviceList = (response.data as List)
          .map((json) => ServiceModel.fromJson(json))
          .toList();
      services.value = serviceList;
    } catch (e) {
      print('Error loading services: $e');
    }
  }

  void selectPet(PetModel pet) {
    selectedPet.value = pet;
    calculatePrice();
  }

  void selectService(ServiceModel service) {
    selectedService.value = service;
    calculatePrice();
  }

  void selectBookingType(BookingType type) {
    bookingType.value = type;
    calculatePrice();
  }

  void toggleCrate() {
    needsCrate.value = !needsCrate.value;
    calculatePrice();
  }

  void toggleMedication() {
    needsMedication.value = !needsMedication.value;
    calculatePrice();
  }

  void updateWaitReturnHours(int hours) {
    waitReturnHours.value = hours;
    calculatePrice();
  }

  void toggleSpecialTime() {
    isSpecialTime.value = !isSpecialTime.value;
    calculatePrice();
  }

  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      selectedDate.value = date;
    }
  }

  Future<void> selectTime() async {
    final time = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      selectedTime.value = time;
    }
  }

  Future<void> selectDropOffDate() async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate:
          selectedDate.value ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: selectedDate.value ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      dropOffDate.value = date;
    }
  }

  Future<void> selectDropOffTime() async {
    final time = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      dropOffTime.value = time;
    }
  }

  Future<void> calculatePrice() async {
    if (selectedService.value == null || selectedPet.value == null) {
      calculatedPrice.value = 0.0;
      return;
    }

    try {
      isCalculatingPrice.value = true;

      final params = {
        'petSize': selectedPet.value!.size.name,
        'isRoundTrip': bookingType.value == BookingType.roundTrip,
        'needsCrate': needsCrate.value,
        'needsMedication': needsMedication.value,
        'waitReturnHours': waitReturnHours.value,
        'isSpecialTime': isSpecialTime.value,
      };

      final response = await _apiProvider.calculatePrice(
        selectedService.value!.id,
        params,
      );

      calculatedPrice.value = response.data['price'].toDouble();
    } catch (e) {
      print('Error calculating price: $e');
    } finally {
      isCalculatingPrice.value = false;
    }
  }

  Future<void> createBooking() async {
    if (!formKey.currentState!.validate()) return;
    if (!_validateBookingData()) return;

    try {
      isLoading.value = true;

      final bookingData = {
        'pickupAddress': pickupAddressController.text.trim(),
        'dropOffAddress': dropOffAddressController.text.trim(),
        'pickupDate': selectedDate.value!.toIso8601String(),
        'pickupTime':
            '${selectedTime.value!.hour.toString().padLeft(2, '0')}:${selectedTime.value!.minute.toString().padLeft(2, '0')}',
        'dropOffDate': dropOffDate.value?.toIso8601String(),
        'dropOffTime': dropOffTime.value != null
            ? '${dropOffTime.value!.hour.toString().padLeft(2, '0')}:${dropOffTime.value!.minute.toString().padLeft(2, '0')}'
            : null,
        'type': bookingType.value.apiValue,
        'petId': selectedPet.value!.id,
        'serviceId': selectedService.value!.id,
        'petSize': selectedPet.value!.size.name,
        'needsCrate': needsCrate.value,
        'needsMedication': needsMedication.value,
        'waitReturnHours': waitReturnHours.value,
        'isSpecialTime': isSpecialTime.value,
        'specialInstructions': specialInstructionsController.text.trim().isEmpty
            ? null
            : specialInstructionsController.text.trim(),
      };

      print('Booking payload:');
      print(bookingData);

      final response = await _apiProvider.createBooking(bookingData);
      final booking = BookingModel.fromJson(response.data);

      Get.showSnackbar(
        const GetSnackBar(
          title: 'Success',
          message: AppConstants.bookingSuccessMessage,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to payment or booking confirmation
      Get.offNamed(AppRoutes.bookingConfirmation, arguments: booking);
    } catch (e) {
      print('Booking creation error: ${e is Exception ? e.toString() : e}');
      if (e is DioError && e.response != null) {
        print('Dio error response data:');
        print(e.response?.data);
      }
      String errorMsg = 'Failed to create booking. Please try again.';
      if (e is Exception && e.toString().isNotEmpty) {
        errorMsg = e.toString();
      }
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: errorMsg,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateBookingData() {
    if (selectedPet.value == null) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Error',
          message: 'Please select a pet',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }

    if (selectedService.value == null) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Error',
          message: 'Please select a service',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }

    if (selectedDate.value == null) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Error',
          message: 'Please select a pickup date',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }

    if (selectedTime.value == null) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Error',
          message: 'Please select a pickup time',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }

    if (bookingType.value == BookingType.roundTrip) {
      if (dropOffDate.value == null) {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Error',
            message: 'Please select a drop-off date for round trip',
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        return false;
      }

      if (dropOffTime.value == null) {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Error',
            message: 'Please select a drop-off time for round trip',
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        return false;
      }
    }

    return true;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }
}
