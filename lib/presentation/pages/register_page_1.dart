import 'package:flutter/material.dart';
import 'package:qualywatchmobile/core/constants/app_assets.dart';
import 'package:qualywatchmobile/core/constants/app_colors.dart';
import 'package:qualywatchmobile/core/constants/app_fonts.dart';
import 'package:qualywatchmobile/core/routing/app_router.dart';
import 'package:qualywatchmobile/presentation/widgets/custom_textfield.dart';
import 'package:qualywatchmobile/presentation/widgets/custom_elevated_button.dart';
import 'package:qualywatchmobile/presentation/widgets/animated_step_indicator.dart';
import 'package:qualywatchmobile/l10n/app_localizations.dart';

class RegisterPage1 extends StatefulWidget {
  const RegisterPage1({Key? key}) : super(key: key);

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      // Store data and navigate to next page
      final managerData = {
        'nom': _nomController.text,
        'prenom': _prenomController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      Navigator.pushNamed(
        context,
        '/auth/register2',
        arguments: {'managerData': managerData},
      );
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

                // Logo
                Image.asset(
                  AppAssets.logo,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 16),

                // Title
                Text(
                  l10n.managerInfo,
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
                  l10n.step('1', '3'),
                  style: AppFonts.urbanist(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 16),

                // Progress indicator
                AnimatedStepIndicator(
                  currentStep: 1,
                  totalSteps: 3,
                ),

                const SizedBox(height: 32),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Nom
                      CustomTextField(
                        label: l10n.lastName,
                        hintText: l10n.enterLastName,
                        prefixIcon: Icons.badge_outlined,
                        controller: _nomController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterLastName;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Prénom
                      CustomTextField(
                        label: l10n.firstName,
                        hintText: l10n.enterFirstName,
                        prefixIcon: Icons.badge_outlined,
                        controller: _prenomController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterFirstName;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Téléphone
                      CustomTextField(
                        label: l10n.phone,
                        hintText: l10n.enterPhone,
                        prefixIcon: Icons.phone_iphone_rounded,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterPhone;
                          }
                          if (value.length < 8) {
                            return l10n.invalidPhone;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Email
                      CustomTextField(
                        label: l10n.email,
                        hintText: l10n.enterEmail,
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

                      // Mot de passe
                      CustomTextField(
                        label: l10n.password,
                        hintText: l10n.createPassword,
                        prefixIcon: Icons.lock_open_rounded,
                        controller: _passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterPassword;
                          }
                          if (value.length < 6) {
                            return l10n.passwordTooShort;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Confirmation mot de passe
                      CustomTextField(
                        label: l10n.confirmPassword,
                        hintText: l10n.confirmPasswordHint,
                        prefixIcon: Icons.lock_rounded,
                        controller: _confirmPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseConfirmPassword;
                          }
                          if (value != _passwordController.text) {
                            return l10n.passwordsDoNotMatch;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),

                      // Bouton Suivant
                      CustomElevatedButton(
                        text: l10n.next,
                        onPressed: _handleNext,
                      ),

                      const SizedBox(height: 24),

                      // Lien de connexion
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${l10n.alreadyHaveAccount} ',
                            style: AppFonts.urbanist(
                              color: AppColors.black,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, AppRouter.login);
                            },
                            child: Text(
                              l10n.login,
                              style: AppFonts.urbanist(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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