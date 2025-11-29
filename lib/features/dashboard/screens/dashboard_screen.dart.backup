import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legal_app/core/theme/app_theme.dart';
import 'package:legal_app/features/info/screens/requirements_list_screen.dart';
import 'package:legal_app/features/orders/screens/order_details_screen.dart';
import 'package:legal_app/features/notifications/screens/notifications_screen.dart';
import 'package:legal_app/features/profile/screens/profile_screen.dart';
import 'package:legal_app/features/chat/screens/chat_screen.dart';
import 'package:legal_app/features/orders/screens/all_orders_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final orders = [
      {
        'id': 'ORD-001',
        'name': 'TechVision Ltd',
        'type': 'Private Limited Company',
        'status': 'Pending',
        'date': 'Nov 27, 2025',
      },
      {
        'id': 'ORD-002',
        'name': 'Green Earth NGO',
        'type': 'Incorporated Trustees',
        'status': 'Processing',
        'date': 'Nov 25, 2025',
      },
      {
        'id': 'ORD-003',
        'name': 'Sunrise Bakery',
        'type': 'Business Name',
        'status': 'Completed',
        'date': 'Nov 20, 2025',
      },
    ];

    final activeOrders = orders
        .where((o) => o['status'] != 'Completed')
        .toList();
    final completedOrders = orders
        .where((o) => o['status'] == 'Completed')
        .toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.notifications_outlined),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              icon: const Icon(Icons.person_outline),
            ),
          ],
        ),
        body: Column(
          children: [
            // Welcome Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryColor, Color(0xFF1A2F4B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Tobi',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Track your company registrations and manage your documents.',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(),
            ),

            // View All Orders Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AllOrdersScreen()),
                  );
                },
                icon: const Icon(Icons.list_alt),
                label: const Text('View All Orders'),
              ),
            ),

            // Tab Bar
            TabBar(
              labelColor: AppTheme.primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppTheme.secondaryColor,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Active Orders'),
                Tab(text: 'Completed'),
              ],
            ),

            // Tab View
            Expanded(
              child: TabBarView(
                children: [
                  // Active Orders Tab
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: activeOrders.isEmpty
                        ? [const Center(child: Text('No active orders'))]
                        : activeOrders
                              .map((order) => _buildOrderCard(context, order))
                              .toList(),
                  ),

                  // Completed Orders Tab
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: completedOrders.isEmpty
                        ? [const Center(child: Text('No completed orders'))]
                        : completedOrders
                              .map((order) => _buildOrderCard(context, order))
                              .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RequirementsListScreen()),
            );
          },
          backgroundColor: AppTheme.secondaryColor,
          foregroundColor: AppTheme.primaryColor,
          icon: const Icon(Icons.add),
          label: const Text('New Registration'),
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Map<String, String> order) {
    Color statusColor;
    switch (order['status']) {
      case 'Pending':
        statusColor = AppTheme.warningColor;
        break;
      case 'Processing':
        statusColor = Colors.blue;
        break;
      case 'Completed':
        statusColor = AppTheme.successColor;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderDetailsScreen(
                orderId: order['id']!,
                companyName: order['name']!,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order['status']!,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Text(
                    order['date']!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                order['name']!,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                order['type']!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: order['status'] == 'Completed'
                    ? OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                orderId: order['id']!,
                                orderName: order['name']!,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.report_problem_outlined,
                          size: 18,
                          color: AppTheme.errorColor,
                        ),
                        label: const Text(
                          'Dispute Order',
                          style: TextStyle(color: AppTheme.errorColor),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: AppTheme.errorColor),
                        ),
                      )
                    : OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                orderId: order['id']!,
                                orderName: order['name']!,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.chat_bubble_outline, size: 18),
                        label: const Text('Chat with Support'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideX();
  }
}
