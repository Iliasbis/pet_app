import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/app_constants.dart';
import '../../data/models/booking_model.dart';
import '../../data/models/pet_model.dart';
import '../../data/providers/api_provider.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final SharedPreferences _prefs = Get.find<SharedPreferences>();

  final currentIndex = 0.obs;
  final pets = <PetModel>[].obs;
  final recentBookings = <BookingModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

  void loadHomeData() async {
    try {
      isLoading.value = true;
      await Future.wait([
        loadPets(),
        loadRecentBookings(),
      ]);
    } catch (e) {
      print('Error loading home data: $e');
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

  Future<void> loadRecentBookings() async {
    try {
      final response = await _apiProvider.getBookings();
      final bookingList = (response.data as List)
          .map((json) => BookingModel.fromJson(json))
          .take(3)
          .toList();
      recentBookings.value = bookingList;
    } catch (e) {
      print('Error loading bookings: $e');
    }
  }

  void goToBooking() {
    Get.toNamed(AppRoutes.booking);
  }

  void goToPets() {
    Get.toNamed(AppRoutes.pets);
  }

  void goToBookings() {
    Get.toNamed(AppRoutes.bookings);
  }

  void goToProfile() {
    Get.toNamed(AppRoutes.profile);
  }

  void logout() {
    _prefs.remove(AppConstants.accessTokenKey);
    _prefs.remove(AppConstants.userDataKey);
    _prefs.setBool(AppConstants.isLoggedInKey, false);
    Get.offAllNamed(AppRoutes.login);
  }
}