import 'package:flutter/material.dart';
import 'package:qualywatchmobile/core/constants/app_colors.dart';
import 'package:qualywatchmobile/core/constants/app_fonts.dart';
import 'package:qualywatchmobile/presentation/widgets/custom_textfield.dart';
import 'package:qualywatchmobile/l10n/app_localizations.dart';
import 'package:qualywatchmobile/presentation/widgets/custom_elevated_button.dart';
import 'package:qualywatchmobile/presentation/widgets/animated_step_indicator.dart';

class RegisterPage2 extends StatefulWidget {
  final Map<String, dynamic> managerData;

  const RegisterPage2({Key? key, required this.managerData}) : super(key: key);

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final _formKey = GlobalKey<FormState>();
  final _nomEntrepriseController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _categoryController = TextEditingController();
  final _employeesController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateCreationController = TextEditingController();
  final _locationController = TextEditingController();

  final List<String> _categories = [
    'Restaurant',
    'Hôtel',
    'Café',
    'Commerce',
    'Service',
    'Technologie',
    'Santé',
    'Éducation',
    'Autre',
  ];

  final List<String> _employeeRanges = [
    '1-10',
    '11-50',
    '51-100',
    '101-500',
    '500+',
  ];

  String? _selectedCategory;
  String? _selectedEmployeeRange;

  @override
  void dispose() {
    _nomEntrepriseController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _categoryController.dispose();
    _employeesController.dispose();
    _descriptionController.dispose();
    _dateCreationController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.pleaseSelectCategory)),
        );
        return;
      }

      if (_selectedEmployeeRange == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!.pleaseSelectNumberOfEmployees)),
        );
        return;
      }

      final companyData = {
        'nomEntreprise': _nomEntrepriseController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'category': _selectedCategory,
        'employees': _selectedEmployeeRange,
        'description': _descriptionController.text,
        'dateCreation': _dateCreationController.text,
        'location': _locationController.text,
      };

      Navigator.pushNamed(
        context,
        '/auth/register3',
        arguments: {
          'managerData': widget.managerData,
          'companyData': companyData,
        },
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateCreationController.text =
            '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Title
                Text(
                  l10n.companyInfo,
                  style: AppFonts.luckiestGuy(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                Text(
                  l10n.step('2', '3'),
                  style: AppFonts.urbanist(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 8),

                // Progress indicator
                AnimatedStepIndicator(
                  currentStep: 2,
                  totalSteps: 3,
                ),

                const SizedBox(height: 32),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Nom entreprise
                      CustomTextField(
                        label: l10n.companyName,
                        hintText: l10n.enterName,
                        prefixIcon: Icons.business_center_rounded,
                        controller: _nomEntrepriseController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterName;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Email
                      CustomTextField(
                        label: l10n.companyEmail,
                        hintText: l10n.companyEmailHint,
                        prefixIcon: Icons.alternate_email_rounded,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterEmail;
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return l10n.invalidEmail;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Téléphone
                      CustomTextField(
                        label: l10n.phone,
                        hintText: l10n.enterPhoneNumber,
                        prefixIcon: Icons.call_rounded,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterPhoneNumber;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Category - Custom selector with chips
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.category,
                            style: AppFonts.urbanist(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _categories.map((category) {
                              final isSelected = _selectedCategory == category;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCategory = category;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    category,
                                    style: AppFonts.urbanist(
                                      fontSize: 14,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.textPrimary,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Employees - Custom selector with chips
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.numberOfEmployees,
                            style: AppFonts.urbanist(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.start,
                            children: _employeeRanges.map((range) {
                              final isSelected = _selectedEmployeeRange == range;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedEmployeeRange = range;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    range,
                                    style: AppFonts.urbanist(
                                      fontSize: 14,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.textPrimary,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Description
                      CustomTextField(
                        label: l10n.description,
                        hintText: l10n.describeYourCompany,
                        prefixIcon: Icons.article_rounded,
                        controller: _descriptionController,
                        keyboardType: TextInputType.multiline,
                         maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterDescription;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Date de création
                      CustomTextField(
                        label: l10n.creationDate,
                        hintText: l10n.dateFormat,
                        prefixIcon: Icons.event_rounded,
                        controller: _dateCreationController,
                        readOnly: true,
                        onTap: _selectDate,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseSelectDate;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Location
                      CustomTextField(
                        label: l10n.location,
                        hintText: l10n.cityCountry,
                        prefixIcon: Icons.place_rounded,
                        controller: _locationController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterLocation;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),

                      // Bouton Suivant
                      CustomElevatedButton(
                        onPressed: _handleNext,
                        text: l10n.next,
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}