import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:legal_app/core/theme/app_theme.dart';
import 'package:legal_app/features/registration/screens/registration_form_screen.dart';

class RequirementsListScreen extends StatelessWidget {
  const RequirementsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final companyTypes = [
      {
        'title': 'Business Name',
        'description': 'Ideal for sole proprietors and small partnerships.',
        'price': '₦25,000',
        'requirements': [
          'Proposed Business Name',
          'Passport Photograph',
          'Valid ID Card (NIN, Voter\'s Card, etc.)',
          'Signature',
          'Address of Business',
        ],
      },
      {
        'title': 'Private Limited Company (Ltd)',
        'description': 'Standard structure for most businesses in Nigeria.',
        'price': '₦60,000',
        'requirements': [
          '2 Proposed Company Names',
          'Details of Directors (Min 1)',
          'Details of Shareholders',
          'Valid IDs for all Directors/Shareholders',
          'Signatures',
          'Share Capital Information',
        ],
      },
      {
        'title': 'Incorporated Trustees (NGO)',
        'description': 'For churches, mosques, clubs, and associations.',
        'price': '₦120,000',
        'requirements': [
          '3 Proposed Names',
          'Details of Trustees (Min 2)',
          'Valid IDs for Trustees',
          'Passport Photographs of Trustees',
          'Constitution of the Organization',
          'Newspaper Publication (Included in service)',
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Registration Type')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: companyTypes.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final type = companyTypes[index];
          return _buildTypeCard(context, type);
        },
      ),
    );
  }

  Widget _buildTypeCard(BuildContext context, Map<String, dynamic> type) {
    return Card(
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Text(
          type['title'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppTheme.primaryColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(type['description']),
            const SizedBox(height: 8),
            Text(
              type['price'],
              style: const TextStyle(
                color: AppTheme.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        children: [
          const Divider(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Requirements:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          ...type['requirements'].map<Widget>(
            (req) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: AppTheme.successColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(req)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        RegistrationFormScreen(companyType: type['title']),
                  ),
                );
              },
              child: const Text('Start Registration'),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (100 * 1).ms).slideY(begin: 0.1);
  }
}
