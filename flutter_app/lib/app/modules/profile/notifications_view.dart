import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class NotificationsView extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = const [
    {
      'icon': Icons.pets,
      'title': 'Booking Confirmed',
      'message': 'Your pet ride is scheduled for tomorrow at 10:00 AM.',
      'time': '2h ago',
    },
    {
      'icon': Icons.directions_car,
      'title': 'Driver En Route',
      'message': 'Your driver is on the way to pick up Bella.',
      'time': '1h ago',
    },
    {
      'icon': Icons.check_circle,
      'title': 'Pet Delivered',
      'message': 'Bella has arrived safely at her destination. 🐾',
      'time': '30m ago',
    },
    {
      'icon': Icons.payment,
      'title': 'Payment Received',
      'message': 'Your payment for the ride has been processed.',
      'time': 'Just now',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
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
        child: notifications.isEmpty
            ? _emptyState(context)
            : ListView.separated(
                padding: const EdgeInsets.all(24),
                itemCount: notifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final n = notifications[index];
                  return _notificationCard(context, n);
                },
              ),
      ),
    );
  }

  Widget _notificationCard(BuildContext context, Map<String, dynamic> n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryTurquoise.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(n['icon'], color: AppColors.primaryTurquoise, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  n['title'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTurquoise,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  n['message'],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  n['time'],
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.notifications_off,
                size: 64, color: AppColors.primaryTurquoise),
            const SizedBox(height: 24),
            Text(
              'No notifications yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryTurquoise,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'You\'ll see updates about your bookings, rides, and payments here.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
