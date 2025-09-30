import 'package:flutter/material.dart';
import 'package:qualywatchmobile/core/constants/app_assets.dart';
import 'package:qualywatchmobile/core/constants/app_colors.dart';
import 'package:qualywatchmobile/core/constants/app_fonts.dart';
import 'package:qualywatchmobile/presentation/widgets/custom_textfield.dart';
// Import de votre classe AppColors existante
// import 'path/to/your/app_colors.dart';

// Page de Login
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifiantController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _identifiantController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Logique de connexion
      print('Identifiant: ${_identifiantController.text}');
      print('Mot de passe: ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Image.asset(
                  AppAssets.logo,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),                
                const SizedBox(height: 10),
                 Text(
                  'Connexion',
                 style: AppFonts.luckiestGuy(
                    fontSize: 26, // Légèrement réduit de 28 à 26
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
      
                const Text(
                  'Connectez-vous à votre compte',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Formulaire
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Champ Identifiant
                      CustomTextField(
                        label: 'Identifiant',
                        hintText: 'Entrez votre identifiant',
                        prefixIcon: Icons.person_outline,
                        controller: _identifiantController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre identifiant';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Champ Mot de passe
                      CustomTextField(
                        label: 'Mot de passe',
                        hintText: 'Entrez votre mot de passe',
                        prefixIcon: Icons.lock_outline,
                        controller: _passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre mot de passe';
                          }
                          if (value.length < 6) {
                            return 'Le mot de passe doit contenir au moins 6 caractères';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Mot de passe oublié
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Action mot de passe oublié
                          },
                          child:  Text(
                            'Mot de passe oublié ?',
                            style:  AppFonts.urbanist(
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Bouton de connexion
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child:  Text(
                            'Se connecter',
                            style: AppFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Lien d'inscription
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            'Vous n\'avez pas de compte ? ',
                            style: AppFonts.urbanist(
                              color: AppColors.black,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/auth/register');
                            },
                            child: const Text(
                              'S\'inscrire',
                              style: TextStyle(
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