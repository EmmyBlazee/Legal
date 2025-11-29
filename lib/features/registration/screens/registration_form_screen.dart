import 'package:flutter/material.dart';
import 'package:legal_app/features/registration/screens/document_upload_screen.dart';
import 'package:legal_app/core/theme/app_theme.dart';
import 'package:legal_app/features/registration/widgets/registration_stepper.dart';
import 'package:legal_app/core/services/draft_service.dart';

class RegistrationFormScreen extends StatefulWidget {
  final String companyType;

  const RegistrationFormScreen({super.key, required this.companyType});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _altNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _natureOfBusinessController = TextEditingController();
  final _shareCapitalController = TextEditingController();
  final _draftService = DraftService();

  @override
  void initState() {
    super.initState();
    _checkDraft();
  }

  Future<void> _checkDraft() async {
    final draft = await _draftService.getDraft(widget.companyType);
    if (draft != null && mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Resume Application?'),
          content: const Text(
            'We found a saved draft for this registration type. Would you like to continue where you left off?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                _draftService.clearDraft(widget.companyType);
                Navigator.pop(context);
              },
              child: const Text('Start New'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _nameController.text = draft['name'] ?? '';
                  _altNameController.text = draft['altName'] ?? '';
                  _addressController.text = draft['address'] ?? '';
                  _natureOfBusinessController.text =
                      draft['natureOfBusiness'] ?? '';
                  _shareCapitalController.text = draft['shareCapital'] ?? '';
                });
                Navigator.pop(context);
              },
              child: const Text('Resume'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _saveDraft() async {
    final data = {
      'name': _nameController.text,
      'altName': _altNameController.text,
      'address': _addressController.text,
      'natureOfBusiness': _natureOfBusinessController.text,
      'shareCapital': _shareCapitalController.text,
    };
    await _draftService.saveDraft(widget.companyType, data);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Draft saved successfully')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.companyType),
        actions: [
          TextButton.icon(
            onPressed: _saveDraft,
            icon: const Icon(Icons.save_outlined, color: AppTheme.primaryColor),
            label: const Text('Save & Exit'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const RegistrationStepper(currentStep: 0),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Company Details',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please provide the proposed names for your company.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Proposed Company Name (1st Choice)',
                        hintText: 'e.g. TechVision Global Ltd',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _altNameController,
                      decoration: const InputDecoration(
                        labelText: 'Proposed Company Name (2nd Choice)',
                        hintText: 'Optional but recommended',
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Contact Information',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Registered Company Address',
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Business Details',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _natureOfBusinessController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Nature of Business',
                        hintText:
                            'e.g. Software Development, General Merchandise',
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please describe the nature of business';
                        }
                        return null;
                      },
                    ),
                    if (widget.companyType.contains('Limited')) ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _shareCapitalController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Share Capital (₦)',
                          hintText: 'e.g. 1,000,000',
                          prefixText: '₦ ',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter share capital';
                          }
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Proceeding to document upload...',
                                ),
                                backgroundColor: AppTheme.successColor,
                                duration: Duration(seconds: 1),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DocumentUploadScreen(
                                  companyType: widget.companyType,
                                  companyName: _nameController.text,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Next: Upload Documents'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
