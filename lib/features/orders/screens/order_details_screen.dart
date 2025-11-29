import 'package:flutter/material.dart';
import 'package:legal_app/core/theme/app_theme.dart';
import 'package:legal_app/features/chat/screens/chat_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final String companyName;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order #$orderId')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.hourglass_top,
                    size: 48,
                    color: AppTheme.warningColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Registration Pending',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We are currently reviewing your submitted documents. This usually takes 24-48 hours.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Timeline', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildTimelineItem(
              context,
              title: 'Order Placed',
              date: 'Nov 27, 10:30 AM',
              isCompleted: true,
              isLast: false,
            ),
            _buildTimelineItem(
              context,
              title: 'Payment Confirmed',
              date: 'Nov 27, 10:35 AM',
              isCompleted: true,
              isLast: false,
            ),
            _buildTimelineItem(
              context,
              title: 'Documents Review',
              date: 'In Progress',
              isCompleted: false,
              isActive: true,
              isLast: false,
            ),
            _buildTimelineItem(
              context,
              title: 'CAC Submission',
              date: 'Pending',
              isCompleted: false,
              isLast: false,
            ),
            _buildTimelineItem(
              context,
              title: 'Certificate Ready',
              date: 'Pending',
              isCompleted: false,
              isLast: true,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        orderId: orderId,
                        orderName: 'Order #$orderId',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('Contact Support'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required String title,
    required String date,
    required bool isCompleted,
    bool isActive = false,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppTheme.successColor
                    : isActive
                    ? AppTheme.warningColor
                    : Colors.grey.shade300,
                border: isActive
                    ? Border.all(color: AppTheme.warningColor, width: 2)
                    : null,
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: isCompleted
                    ? AppTheme.successColor
                    : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isCompleted || isActive
                      ? AppTheme.textPrimary
                      : AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(date, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}
