import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/app_constants.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  void _initializeApp() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final prefs = Get.find<SharedPreferences>();
      final isLoggedIn = prefs.getBool(AppConstants.isLoggedInKey) ?? false;
      
      if (isLoggedIn) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      print('Error during initialization: $e');
      Get.offAllNamed(AppRoutes.login);
    }
  }
}