import 'package:get/get.dart';
import 'home_controller.dart';
import '../profile/profile_controller.dart';
import '../pets/pets_controller.dart';
import '../bookings/bookings_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<ProfileController>(ProfileController());
    Get.put<PetsController>(PetsController());
    Get.put<BookingsController>(BookingsController());
  }
}
