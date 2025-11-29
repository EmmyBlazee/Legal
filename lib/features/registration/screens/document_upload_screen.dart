import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legal_app/core/theme/app_theme.dart';
import 'package:legal_app/features/registration/screens/payment_screen.dart';
import 'package:legal_app/features/registration/widgets/registration_stepper.dart';

class DocumentUploadScreen extends StatefulWidget {
  final String companyType;
  final String companyName;

  const DocumentUploadScreen({
    super.key,
    required this.companyType,
    required this.companyName,
  });

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _idCardImage;
  File? _signatureImage;
  File? _passportImage;

  Future<void> _pickImage(String type) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Scan Document (Camera)'),
              onTap: () {
                Navigator.pop(context);
                _processImage(type, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Upload from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _processImage(type, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processImage(String type, ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final File file = File(image.path);

      // 1. Technical Validation (Size > 50KB)
      if (!_validateFile(file)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'File is too small. Please upload a clear, high-quality image.',
              ),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
        return;
      }

      // 2. User Verification (Preview Dialog)
      if (mounted) {
        final bool? confirmed = await _showPreviewDialog(file);
        if (confirmed == true) {
          setState(() {
            if (type == 'id') _idCardImage = file;
            if (type == 'signature') _signatureImage = file;
            if (type == 'passport') _passportImage = file;
          });
        }
      }
    }
  }

  bool _validateFile(File file) {
    final int sizeInBytes = file.lengthSync();
    final double sizeInKb = sizeInBytes / 1024;
    return sizeInKb > 50; // Minimum 50KB
  }

  Future<bool?> _showPreviewDialog(File file) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verify Document'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: FileImage(file),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Is this document clear and readable? Blurred documents will be rejected.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Retake'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes, it\'s clear'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Documents')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const RegistrationStepper(currentStep: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Required Documents',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please scan or upload clear images of the following documents.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  _buildUploadCard(
                    'Valid ID Card',
                    'NIN, Voter\'s Card, or International Passport',
                    _idCardImage,
                    () => _pickImage('id'),
                  ),
                  _buildUploadCard(
                    'Signature',
                    'Sign on a white paper and upload',
                    _signatureImage,
                    () => _pickImage('signature'),
                  ),
                  _buildUploadCard(
                    'Passport Photograph',
                    'Recent passport photograph',
                    _passportImage,
                    () => _pickImage('passport'),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate uploads
                        if (_idCardImage != null &&
                            _signatureImage != null &&
                            _passportImage != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentScreen(
                                companyType: widget.companyType,
                                companyName: widget.companyName,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please upload all required documents',
                              ),
                              backgroundColor: AppTheme.errorColor,
                            ),
                          );
                        }
                      },
                      child: const Text('Next: Payment'),
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

  Widget _buildUploadCard(
    String title,
    String subtitle,
    File? file,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: file != null
                      ? AppTheme.successColor.withValues(alpha: 0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: file != null
                        ? AppTheme.successColor
                        : Colors.grey.shade300,
                  ),
                  image: file != null
                      ? DecorationImage(
                          image: FileImage(file),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: file == null
                    ? const Icon(
                        Icons.cloud_upload_outlined,
                        color: AppTheme.primaryColor,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      file != null ? 'Uploaded' : subtitle,
                      style: TextStyle(
                        color: file != null
                            ? AppTheme.successColor
                            : AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (file != null)
                const Icon(Icons.check_circle, color: AppTheme.successColor),
            ],
          ),
        ),
      ),
    );
  }
}
