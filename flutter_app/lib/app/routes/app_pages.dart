import 'package:get/get.dart';
import 'package:palm_kissed_paws/app/modules/profile/about_view.dart';
import 'package:palm_kissed_paws/app/modules/profile/edit_profile_binding.dart';
import 'package:palm_kissed_paws/app/modules/profile/edit_profile_view.dart';
import 'package:palm_kissed_paws/app/modules/profile/help_support_view.dart';
import 'package:palm_kissed_paws/app/modules/profile/notifications_view.dart';
import 'package:palm_kissed_paws/app/modules/profile/payment_methods_view.dart';
import 'package:palm_kissed_paws/app/modules/profile/privacy_security_view.dart';
import 'package:palm_kissed_paws/app/modules/loyalty/loyalty_binding.dart';
import 'package:palm_kissed_paws/app/modules/loyalty/loyalty_view.dart';
import 'package:palm_kissed_paws/app/modules/recurring_rides/recurring_rides_binding.dart';
import 'package:palm_kissed_paws/app/modules/recurring_rides/recurring_rides_view.dart';
import 'package:palm_kissed_paws/app/modules/tracking/tracking_binding.dart';
import 'package:palm_kissed_paws/app/modules/tracking/tracking_view.dart';
import 'package:palm_kissed_paws/app/modules/messages/messages_binding.dart';
import 'package:palm_kissed_paws/app/modules/messages/messages_view.dart';

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
import '../modules/pets/pets_binding.dart';
import '../modules/pets/pets_view.dart';
import '../modules/pets/add_pet/add_pet_binding.dart';
import '../modules/pets/add_pet/add_pet_view.dart';
import '../modules/booking/booking_binding.dart';
import '../modules/booking/booking_view.dart';
import '../modules/bookings/bookings_binding.dart';
import '../modules/bookings/bookings_view.dart';
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
      name: AppRoutes.pets,
      page: () => PetsView(),
      binding: PetsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addPet,
      page: () => const AddPetView(),
      binding: AddPetBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.booking,
      page: () => BookingView(),
      binding: BookingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.bookings,
      page: () => BookingsView(),
      binding: BookingsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => NotificationsView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => PaymentMethodsView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => PrivacySecurityView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.help,
      page: () => HelpSupportView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => AboutView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.loyalty,
      page: () => const LoyaltyView(),
      binding: LoyaltyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.recurringRides,
      page: () => const RecurringRidesView(),
      binding: RecurringRidesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.tracking,
      page: () => const TrackingView(),
      binding: TrackingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.messages,
      page: () => const MessagesView(),
      binding: MessagesBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
