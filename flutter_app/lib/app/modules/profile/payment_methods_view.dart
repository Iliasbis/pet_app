import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class PaymentMethodsView extends StatelessWidget {
  final List<Map<String, dynamic>> paymentMethods = const [
    {
      'type': 'Visa',
      'icon': Icons.credit_card,
      'details': '**** 1234',
      'isDefault': true,
    },
    {
      'type': 'PayPal',
      'icon': Icons.account_balance_wallet,
      'details': 'john.doe@email.com',
      'isDefault': false,
    },
    {
      'type': 'Apple Pay',
      'icon': Icons.phone_iphone,
      'details': 'Connected',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
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
        child: paymentMethods.isEmpty
            ? _emptyState(context)
            : ListView.separated(
                padding: const EdgeInsets.all(24),
                itemCount: paymentMethods.length + 1,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  if (index == paymentMethods.length) {
                    return _addButton(context);
                  }
                  final method = paymentMethods[index];
                  return _paymentCard(context, method);
                },
              ),
      ),
    );
  }

  Widget _paymentCard(BuildContext context, Map<String, dynamic> method) {
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
        children: [
          Icon(method['icon'], color: AppColors.primaryTurquoise, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      method['type'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryTurquoise,
                          ),
                    ),
                    if (method['isDefault'])
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primaryTurquoise.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Default',
                          style: TextStyle(
                            color: AppColors.primaryTurquoise,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  method['details'],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
            onPressed: () {
              // TODO: Show options (set default, remove, etc.)
            },
          ),
        ],
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryTurquoise,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add Payment Method'),
        onPressed: () {
          // TODO: Implement add payment method flow
        },
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
            const Icon(Icons.credit_card,
                size: 64, color: AppColors.primaryTurquoise),
            const SizedBox(height: 24),
            Text(
              'No payment methods',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryTurquoise,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Add a card or wallet to pay for your pet rides quickly and securely.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _addButton(context),
          ],
        ),
      ),
    );
  }
}
