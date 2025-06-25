import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class HelpSupportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
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
              _sectionTitle(
                  context, 'Frequently Asked Questions', Icons.help_outline),
              const SizedBox(height: 12),
              _faq('How do I book a ride?',
                  'Go to the "Book a Ride" section, select your pet, choose a service, and follow the prompts to schedule your ride.'),
              _faq('What areas do you serve?',
                  'We provide local pet transportation within our service area. Check the app or website for the latest coverage.'),
              _faq('How do I pay for a ride?',
                  'You can pay securely in-app using Stripe or PayPal when booking your ride.'),
              _faq('Can I track my pet during the ride?',
                  'In-app ride tracking is coming soon! For now, you will receive notifications for pickup and delivery.'),
              _faq('How do I contact support?',
                  'See the contact options below or email us at info@palmkissedpaws.com.'),
              const SizedBox(height: 32),
              _sectionTitle(context, 'Contact Us', Icons.email_outlined),
              const SizedBox(height: 12),
              _contactRow('Email', 'info@palmkissedpaws.com'),
              _contactRow('Website', 'www.palmkissedpaws.com'),
              const SizedBox(height: 24),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryTurquoise.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Need urgent help?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primaryTurquoise,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'For urgent issues, please email us with "URGENT" in the subject line. We will get back to you as soon as possible!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  "We're here to help you and your pets have a safe, happy journey! 🐾",
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

  Widget _faq(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.primaryTurquoise,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _contactRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    );
  }
}
