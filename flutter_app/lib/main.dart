import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/core/theme/app_theme.dart';
import 'app/core/utils/app_constants.dart';
import 'app/data/providers/api_provider.dart';
import 'app/services/notification_service.dart';
import 'app/services/socket_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // System UI Configuration
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs);

  // Initialize Services
  Get.put(ApiProvider());
  Get.put(NotificationService());
  Get.put(SocketService());

  runApp(const PalmKissedPawsApp());
}

class PalmKissedPawsApp extends StatelessWidget {
  const PalmKissedPawsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
