import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';
import '../../core/utils/app_localizations_helper.dart';
import 'onboarding_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _contentController;
  late AnimationController _buttonController;

  late Animation<double> _backgroundScaleAnimation;
  late Animation<double> _contentOpacityAnimation;
  late Animation<Offset> _contentSlideAnimation;
  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _buttonOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _backgroundScaleAnimation = Tween<double>(
      begin: 1.2,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeOutCubic,
    ));

    _contentOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeIn,
    ));

    _contentSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeOutCubic,
    ));

    _buttonScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.elasticOut,
    ));

    _buttonOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeIn,
    ));
  }

  void _startAnimations() async {
    _backgroundController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    _contentController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _buttonController.forward();
  }

  void _navigateToOnboarding() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 5000),
      ),
    );
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _contentController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _backgroundController,
          _contentController,
          _buttonController,
        ]),
        builder: (context, child) {
          return Stack(
            children: [
              // Background image with scale animation
              Transform.scale(
                scale: _backgroundScaleAnimation.value,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.start),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Gradient overlay
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),

              // Content
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const Spacer(flex: 2),

                      // Welcome content with slide and opacity animations
                      SlideTransition(
                        position: _contentSlideAnimation,
                        child: FadeTransition(
                          opacity: _contentOpacityAnimation,
                          child: Column(
                            children: [
                              // Welcome text
                              Text(
                                AppLocalizationsHelper.welcome(context),
                                style: AppFonts.coiny(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                  letterSpacing: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(height: 20),

                              // App name
                              Text(
                                'QualyWatch',
                                style: AppFonts.coiny(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  letterSpacing: 2,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(height: 30),

                              // Description
                              Text(
                                'Partagez vos expériences et gagnez des récompenses en quelques clics',
                                style: AppFonts.courgette(
                                  fontSize: 20,
                                  color: AppColors.white.withOpacity(0.9),
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(flex: 3),

                      // Start button with scale and opacity animations
                      Transform.scale(
                        scale: _buttonScaleAnimation.value,
                        child: FadeTransition(
                          opacity: _buttonOpacityAnimation,
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              gradient: AppColors.primaryGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(28),
                                onTap: _navigateToOnboarding,
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppLocalizationsHelper.getStarted(context),
                                        style: AppFonts.buttonText.copyWith(
                                          color: AppColors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: AppColors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: AppColors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}