import 'package:flutter/material.dart';
import 'package:legal_app/core/theme/app_theme.dart';
import 'package:legal_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:legal_app/features/registration/widgets/registration_stepper.dart';

class PaymentScreen extends StatefulWidget {
  final String companyType;
  final String companyName;

  const PaymentScreen({
    super.key,
    required this.companyType,
    required this.companyName,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isProcessing = false;
  String _paymentMethod = 'card';

  String get _price {
    if (widget.companyType.contains('Business Name')) return '25,000';
    if (widget.companyType.contains('NGO')) return '120,000';
    return '60,000';
  }

  void _processPayment() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isProcessing = true);
    // Simulate payment gateway
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            size: 60,
            color: AppTheme.successColor,
          ),
          title: const Text('Payment Successful'),
          content: const Text(
            'Your registration request has been submitted successfully. You can track the progress on your dashboard.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  (route) => false,
                );
              },
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const RegistrationStepper(currentStep: 2),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₦$_price',
                          style: const TextStyle(
                            color: AppTheme.secondaryColor,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(color: Colors.white24, height: 32),
                        _buildSummaryRow('Service', widget.companyType),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Information',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'Where we will send your certificate',
                            prefixIcon: Icon(Icons.email_outlined),
                            helperText:
                                'The certificate will be sent to this email address.',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Payment Method',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: RadioListTile<String>(
                      value: 'card',
                      groupValue: _paymentMethod,
                      onChanged: (value) =>
                          setState(() => _paymentMethod = value!),
                      title: const Text('Pay with Card'),
                      subtitle: const Text('Visa, Mastercard, Verve'),
                      secondary: const Icon(
                        Icons.credit_card,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  Card(
                    child: RadioListTile<String>(
                      value: 'transfer',
                      groupValue: _paymentMethod,
                      onChanged: (value) =>
                          setState(() => _paymentMethod = value!),
                      title: const Text('Bank Transfer'),
                      secondary: const Icon(
                        Icons.account_balance,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isProcessing ? null : _processPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.successColor,
                      ),
                      child: _isProcessing
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text('Pay ₦$_price'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text(
          value.length > 20 ? '${value.substring(0, 18)}...' : value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
