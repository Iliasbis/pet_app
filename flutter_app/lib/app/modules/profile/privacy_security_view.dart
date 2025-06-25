import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class PrivacySecurityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security'),
        backgroundColor: AppColors.primaryTurquoise,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryTurquoise, Colors.white],
            stops: [0.0, 0.4],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _sectionTitle(context, 'Platform Preferences', Icons.settings),
              const SizedBox(height: 12),
              _bullet(
                  'App: Flutter, React Native, or similar cross-platform tool'),
              _bullet('Website: Wix (custom domain connected)'),
              _bullet('Payments: Stripe + PayPal'),
              _bullet('Messaging (Phase 2): In-app or email integration'),
              _bullet('Scheduling: Calendar sync + availability management'),
              const SizedBox(height: 32),
              _sectionTitle(context, 'Optional Bonus Features', Icons.star),
              const SizedBox(height: 12),
              _bullet('In-app ride tracking (map/GPS for scheduled rides)'),
              _bullet('Notifications for booking, pickup, delivery'),
              _bullet('Ratings & feedback for each ride'),
              _bullet('Customer referral or loyalty program'),
              _bullet('Admin mobile app or dashboard access'),
              const SizedBox(height: 32),
              _sectionTitle(context, 'Security & Compliance', Icons.lock),
              const SizedBox(height: 12),
              _bullet('SSL for website'),
              _bullet('Stripe/PayPal secure payment'),
              _bullet('Pet profile data stored securely'),
              _bullet('User login authentication'),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  "Your privacy and your pet's safety are our top priorities! 🐾",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryTurquoise),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTurquoise,
              ),
        ),
      ],
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ',
              style:
                  TextStyle(fontSize: 18, color: AppColors.primaryTurquoise)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
