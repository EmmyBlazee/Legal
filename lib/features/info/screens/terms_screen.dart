import 'package:flutter/material.dart';
import 'package:legal_app/core/theme/app_theme.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
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
              title: '1. Acceptance of Terms',
              content:
                  'By accessing and using this CAC Registration service, you accept and agree to be bound by the terms and provision of this agreement.',
            ),
            _buildSection(
              context,
              title: '2. Description of Service',
              content:
                  'We provide assistance with Corporate Affairs Commission (CAC) business registration in Nigeria. Our services include company name reservation, document preparation, filing, and tracking of registration status.',
            ),
            _buildSection(
              context,
              title: '3. User Obligations',
              content:
                  'You agree to provide accurate, current, and complete information during registration. You are responsible for maintaining the confidentiality of your account credentials and for all activities under your account.',
            ),
            _buildSection(
              context,
              title: '4. Payment Terms',
              content:
                  'All fees must be paid in advance unless otherwise agreed. Prices are subject to change with notice. Refunds are processed according to our refund policy.',
            ),
            _buildSection(
              context,
              title: '5. Service Limitations',
              content:
                  'We act as intermediaries between you and the CAC. Final approval and processing times are subject to CAC policies and procedures, which are beyond our control.',
            ),
            _buildSection(
              context,
              title: '6. Intellectual Property',
              content:
                  'All content, trademarks, and data on this application are the property of our company or our licensors. Unauthorized use is prohibited.',
            ),
            _buildSection(
              context,
              title: '7. Limitation of Liability',
              content:
                  'We are not liable for any delays or failures in service delivery caused by the CAC or other third parties. Our liability is limited to the fees paid for our services.',
            ),
            _buildSection(
              context,
              title: '8. Privacy',
              content:
                  'Your use of our service is also governed by our Privacy Policy. Please review it to understand our practices.',
            ),
            _buildSection(
              context,
              title: '9. Modification of Terms',
              content:
                  'We reserve the right to modify these terms at any time. Continued use of the service after changes constitutes acceptance of new terms.',
            ),
            _buildSection(
              context,
              title: '10. Contact Information',
              content:
                  'For questions about these Terms and Conditions, please contact us through the app\'s support channels.',
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
