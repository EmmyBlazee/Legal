import 'package:flutter/material.dart';
import 'package:legal_app/core/theme/app_theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: ${DateTime.now().year}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: '1. Information We Collect',
              content:
                  'We collect information you provide directly to us, including:\n\n• Personal identification information (name, email, phone number)\n• Business information (company names, addresses, nature of business)\n• Payment information\n• Communication records\n• Device information and usage data',
            ),
            _buildSection(
              context,
              title: '2. How We Use Your Information',
              content:
                  'We use the information we collect to:\n\n• Process your CAC registration requests\n• Communicate with you about your orders\n• Process payments and send receipts\n• Improve our services\n• Send administrative information\n• Comply with legal obligations',
            ),
            _buildSection(
              context,
              title: '3. Information Sharing',
              content:
                  'We share your information with:\n\n• The Corporate Affairs Commission (CAC) for registration processing\n• Payment processors to handle transactions\n• Service providers who assist our operations\n• Legal authorities when required by law\n\nWe do not sell your personal information to third parties.',
            ),
            _buildSection(
              context,
              title: '4. Data Security',
              content:
                  'We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.',
            ),
            _buildSection(
              context,
              title: '5. Data Retention',
              content:
                  'We retain your information for as long as necessary to provide services and comply with legal obligations. Registration records are kept for a minimum of 7 years as required by law.',
            ),
            _buildSection(
              context,
              title: '6. Your Rights',
              content:
                  'You have the right to:\n\n• Access your personal information\n• Correct inaccurate data\n• Request deletion of your data (subject to legal requirements)\n• Object to processing of your data\n• Withdraw consent at any time',
            ),
            _buildSection(
              context,
              title: '7. Cookies and Tracking',
              content:
                  'We use cookies and similar technologies to improve user experience, analyze usage patterns, and personalize content.',
            ),
            _buildSection(
              context,
              title: '8. Children\'s Privacy',
              content:
                  'Our services are not intended for individuals under 18 years of age. We do not knowingly collect information from children.',
            ),
            _buildSection(
              context,
              title: '9. Changes to Privacy Policy',
              content:
                  'We may update this privacy policy from time to time. We will notify you of significant changes through the app or via email.',
            ),
            _buildSection(
              context,
              title: '10. Contact Us',
              content:
                  'If you have questions about this privacy policy or our data practices, please contact us through the app\'s support channels.',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
