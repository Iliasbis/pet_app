import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/app_constants.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print('SplashController: onInit called');
    _initializeApp();
  }

  void _initializeApp() async {
    print('SplashController: _initializeApp started');
    try {
      await Future.delayed(const Duration(seconds: 2));
      final prefs = Get.find<SharedPreferences>();
      final isLoggedIn = prefs.getBool(AppConstants.isLoggedInKey) ?? false;
      if (isLoggedIn) {
        print('SplashController: User is logged in, navigating to home');
        Get.offAllNamed(AppRoutes.home);
        print('SplashController: Called Get.offAllNamed(AppRoutes.home)');
      } else {
        print('SplashController: User is not logged in, navigating to login');
        Get.offAllNamed(AppRoutes.login);
        print('SplashController: Called Get.offAllNamed(AppRoutes.login)');
      }
    } catch (e) {
      print('SplashController: Error during initialization: $e');
      Get.offAllNamed(AppRoutes.login);
      print(
          'SplashController: Called Get.offAllNamed(AppRoutes.login) in catch');
    }
  }
}
