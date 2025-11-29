import 'package:flutter/material.dart';
import 'package:legal_app/core/theme/app_theme.dart';
import 'package:legal_app/features/orders/screens/order_details_screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  final _searchController = TextEditingController();
  String _filterStatus = 'All';
  String _searchQuery = '';

  // Mock data
  final List<Map<String, dynamic>> _allOrders = [
    {
      'id': 'ORD-2024-001',
      'companyName': 'TechVision Global Ltd',
      'type': 'Limited Liability Company',
      'status': 'In Progress',
      'statusColor': AppTheme.warningColor,
      'date': '2024-01-15',
      'amount': '₦60,000',
    },
    {
      'id': 'ORD-2024-002',
      'companyName': 'QuickMart Traders',
      'type': 'Business Name',
      'status': 'Completed',
      'statusColor': AppTheme.successColor,
      'date': '2024-01-10',
      'amount': '₦25,000',
    },
    {
      'id': 'ORD-2024-003',
      'companyName': 'Green Earth NGO',
      'type': 'Non-Governmental Organization',
      'status': 'Under Review',
      'statusColor': Colors.blue,
      'date': '2024-01-20',
      'amount': '₦120,000',
    },
    {
      'id': 'ORD-2024-004',
      'companyName': 'Digital Innovations Ltd',
      'type': 'Limited Liability Company',
      'status': 'Completed',
      'statusColor': AppTheme.successColor,
      'date': '2024-01-05',
      'amount': '₦60,000',
    },
    {
      'id': 'ORD-2024-005',
      'companyName': 'Food Express',
      'type': 'Business Name',
      'status': 'In Progress',
      'statusColor': AppTheme.warningColor,
      'date': '2024-01-18',
      'amount': '₦25,000',
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    var filtered = _allOrders.where((order) {
      final matchesSearch =
          order['companyName'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          order['id'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

      final matchesFilter =
          _filterStatus == 'All' || order['status'] == _filterStatus;

      return matchesSearch && matchesFilter;
    }).toList();

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Orders')),
      body: Column(
        children: [
          // Search and Filter
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by order ID or company name',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All'),
                      _buildFilterChip('In Progress'),
                      _buildFilterChip('Under Review'),
                      _buildFilterChip('Completed'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Orders List
          Expanded(
            child: _filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No orders found',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = _filteredOrders[index];
                      return _buildOrderCard(order);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _filterStatus == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() => _filterStatus = label);
        },
        selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderDetailsScreen(
                orderId: order['id'],
                companyName: order['companyName'],
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order['id'],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: order['statusColor'].withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      order['status'],
                      style: TextStyle(
                        fontSize: 12,
                        color: order['statusColor'],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                order['companyName'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                order['type'],
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order['date'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    order['amount'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
