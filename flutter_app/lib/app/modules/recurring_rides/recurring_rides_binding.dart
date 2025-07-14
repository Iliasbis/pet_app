import 'package:get/get.dart';
import 'recurring_rides_controller.dart';

class RecurringRidesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecurringRidesController>(
      () => RecurringRidesController(),
    );
  }
}