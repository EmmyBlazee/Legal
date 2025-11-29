import 'package:flutter/material.dart';
import 'package:legal_app/core/theme/app_theme.dart';

class RegistrationStepper extends StatelessWidget {
  final int currentStep;

  const RegistrationStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      color: Colors.white,
      child: Row(
        children: [
          _buildStep(context, 0, 'Details', isFirst: true),
          _buildConnector(context, 0),
          _buildStep(context, 1, 'Documents'),
          _buildConnector(context, 1),
          _buildStep(context, 2, 'Payment', isLast: true),
        ],
      ),
    );
  }

  Widget _buildStep(
    BuildContext context,
    int stepIndex,
    String label, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    final isActive = stepIndex == currentStep;
    final isCompleted = stepIndex < currentStep;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive || isCompleted
                  ? AppTheme.primaryColor
                  : Colors.grey.shade200,
              border: Border.all(
                color: isActive || isCompleted
                    ? AppTheme.primaryColor
                    : Colors.grey.shade300,
              ),
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : Text(
                      '${stepIndex + 1}',
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive || isCompleted
                  ? AppTheme.primaryColor
                  : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnector(BuildContext context, int stepIndex) {
    final isCompleted = stepIndex < currentStep;
    return Expanded(
      child: Container(
        height: 2,
        color: isCompleted ? AppTheme.primaryColor : Colors.grey.shade200,
        margin: const EdgeInsets.only(bottom: 20), // Align with circle center
      ),
    );
  }
}
