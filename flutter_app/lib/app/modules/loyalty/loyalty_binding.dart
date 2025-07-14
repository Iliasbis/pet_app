import 'package:get/get.dart';
import 'loyalty_controller.dart';

class LoyaltyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoyaltyController>(
      () => LoyaltyController(),
    );
  }
}