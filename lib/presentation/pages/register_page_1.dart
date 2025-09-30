import 'package:flutter/material.dart';
import 'package:qualywatchmobile/core/constants/app_assets.dart';
import 'package:qualywatchmobile/core/constants/app_colors.dart';
import 'package:qualywatchmobile/core/constants/app_fonts.dart';
import 'package:qualywatchmobile/core/routing/app_router.dart';
import 'package:qualywatchmobile/presentation/widgets/custom_textfield.dart';

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
                  'Informations du Gérant',
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
                  'Étape 1/3',
                  style: AppFonts.urbanist(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 8),

                // Progress indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProgressDot(number: 1, isActive: true),
                    _buildProgressLine(),
                    _buildProgressDot(number: 2, isActive: false),
                    _buildProgressLine(),
                    _buildProgressDot(number: 3, isActive: false),
                  ],
                ),

                const SizedBox(height: 32),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Nom
                      CustomTextField(
                        label: 'Nom',
                        hintText: 'Entrez votre nom',
                        prefixIcon: Icons.badge_outlined,
                        controller: _nomController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre nom';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Prénom
                      CustomTextField(
                        label: 'Prénom',
                        hintText: 'Entrez votre prénom',
                        prefixIcon: Icons.badge_outlined,
                        controller: _prenomController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre prénom';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Téléphone
                      CustomTextField(
                        label: 'Téléphone',
                        hintText: 'Entrez votre numéro',
                        prefixIcon: Icons.phone_iphone_rounded,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre numéro';
                          }
                          if (value.length < 8) {
                            return 'Numéro invalide';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Email
                      CustomTextField(
                        label: 'Email',
                        hintText: 'Entrez votre email',
                        prefixIcon: Icons.alternate_email_rounded,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Email invalide';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Mot de passe
                      CustomTextField(
                        label: 'Mot de passe',
                        hintText: 'Créez un mot de passe',
                        prefixIcon: Icons.lock_open_rounded,
                        controller: _passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir un mot de passe';
                          }
                          if (value.length < 6) {
                            return 'Le mot de passe doit contenir au moins 6 caractères';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Confirmation mot de passe
                      CustomTextField(
                        label: 'Confirmer le mot de passe',
                        hintText: 'Confirmez votre mot de passe',
                        prefixIcon: Icons.lock_rounded,
                        controller: _confirmPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez confirmer votre mot de passe';
                          }
                          if (value != _passwordController.text) {
                            return 'Les mots de passe ne correspondent pas';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),

                      // Bouton Suivant
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _handleNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Suivant',
                            style: AppFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Lien de connexion
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Vous avez déjà un compte ? ',
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
                              'Se connecter',
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

  Widget _buildProgressDot({required int number, required bool isActive}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.primary : Colors.white,
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.grey,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '$number',
          style: AppFonts.urbanist(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppColors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressLine() {
    return Container(
      width: 40,
      height: 2,
      color: AppColors.grey,
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}