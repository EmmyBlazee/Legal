import 'package:flutter/material.dart';
import 'package:legal_app/core/theme/app_theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            _buildFAQ(
              context,
              question: 'How long does the registration process take?',
              answer:
                  'Typical CAC registration takes 5-10 business days, depending on the type of business and CAC\'s workload. We\'ll keep you updated throughout the process.',
            ),
            _buildFAQ(
              context,
              question: 'What documents do I need?',
              answer:
                  'You\'ll need:\n• Valid ID card (National ID, Driver\'s License, or International Passport)\n• Passport photograph\n• Signature\n• Proposed company names\n• Business address',
            ),
            _buildFAQ(
              context,
              question: 'Can I change my company name after registration?',
              answer:
                  'Yes, but it requires a formal name change process with the CAC, which involves additional fees and documentation.',
            ),
            _buildFAQ(
              context,
              question: 'What payment methods do you accept?',
              answer:
                  'We accept card payments (Visa, Mastercard, Verve) and bank transfers. All payments are secure and encrypted.',
            ),
            _buildFAQ(
              context,
              question: 'Can I track my registration status?',
              answer:
                  'Yes! Use the Dashboard to view real-time status updates for all your registrations.',
            ),
            _buildFAQ(
              context,
              question: 'What if my company name is rejected?',
              answer:
                  'If your first choice is rejected, we\'ll automatically process your alternative name. That\'s why we ask for a second choice during registration.',
            ),
            _buildFAQ(
              context,
              question: 'Do you offer refunds?',
              answer:
                  'Refunds are available if we cannot complete your registration due to our error. CAC fees are non-refundable once paid.',
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            Text(
              'Contact Information',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildContactTile(
              icon: Icons.email_outlined,
              title: 'Email',
              subtitle: 'support@legalapp.com',
            ),
            _buildContactTile(
              icon: Icons.phone_outlined,
              title: 'Phone',
              subtitle: '+234 800 000 0000',
            ),
            _buildContactTile(
              icon: Icons.location_on_outlined,
              title: 'Address',
              subtitle: 'Lagos, Nigeria',
            ),
            const SizedBox(height: 24),
            Text(
              'Office Hours',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Monday - Friday: 9:00 AM - 5:00 PM WAT\nSaturday: 10:00 AM - 2:00 PM WAT\nSunday: Closed',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQ(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(answer, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
      contentPadding: EdgeInsets.zero,
    );
  }
}
