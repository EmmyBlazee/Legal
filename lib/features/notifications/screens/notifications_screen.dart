import 'package:flutter/material.dart';
import 'package:legal_app/core/theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final notifications = [
      {
        'title': 'Registration Update',
        'message': 'Your business name "TechVision Ltd" has been approved.',
        'time': '2 hours ago',
        'isRead': false,
      },
      {
        'title': 'Payment Successful',
        'message': 'We received your payment of ₦60,000.',
        'time': '1 day ago',
        'isRead': true,
      },
      {
        'title': 'Welcome',
        'message': 'Welcome to Legal App! Start your registration today.',
        'time': '2 days ago',
        'isRead': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final isRead = notification['isRead'] as bool;

          return Card(
            color: isRead
                ? AppTheme.surfaceColor
                : AppTheme.primaryColor.withValues(alpha: 0.05),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications,
                  color: AppTheme.primaryColor,
                ),
              ),
              title: Text(
                notification['title'] as String,
                style: TextStyle(
                  fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(notification['message'] as String),
                  const SizedBox(height: 8),
                  Text(
                    notification['time'] as String,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
