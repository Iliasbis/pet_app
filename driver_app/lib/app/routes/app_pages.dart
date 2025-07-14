import 'package:get/get.dart';

import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';
import '../modules/auth/login/login_binding.dart';
import '../modules/auth/login/login_view.dart';
import '../modules/auth/register/register_binding.dart';
import '../modules/auth/register/register_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/profile/profile_binding.dart';
import '../modules/profile/profile_view.dart';
import '../modules/rides/rides_binding.dart';
import '../modules/rides/rides_view.dart';
import '../modules/ride_details/ride_details_binding.dart';
import '../modules/ride_details/ride_details_view.dart';
import '../modules/navigation/navigation_binding.dart';
import '../modules/navigation/navigation_view.dart';
import '../modules/earnings/earnings_binding.dart';
import '../modules/earnings/earnings_view.dart';
import '../modules/messages/messages_binding.dart';
import '../modules/messages/messages_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.rides,
      page: () => RidesView(),
      binding: RidesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.rideDetails,
      page: () => RideDetailsView(),
      binding: RideDetailsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.navigation,
      page: () => NavigationView(),
      binding: NavigationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.earnings,
      page: () => EarningsView(),
      binding: EarningsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.messages,
      page: () => MessagesView(),
      binding: MessagesBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}