import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qualywatchmobile/core/routing/app_router.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';
import '../../core/utils/app_localizations_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _containerController;
  late AnimationController _textController;
  late AnimationController _dotsController;

  late Animation<double> _containerSlideAnimation;
  late Animation<double> _containerOpacityAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _titleOpacityAnimation;
  late Animation<Offset> _descSlideAnimation;
  late Animation<double> _descOpacityAnimation;
  late Animation<double> _dotsAnimation;

  int _currentPage = 0;
  bool _isLastPage = false;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      image: AppAssets.onboarding1,
      title: 'onboardingTitle1',
      description: 'onboardingDesc1',
    ),
    OnboardingData(
      image: AppAssets.onboarding2,
      title: 'onboardingTitle2',
      description: 'onboardingDesc2',
    ),
    OnboardingData(
      image: AppAssets.onboarding3,
      title: 'onboardingTitle3',
      description: 'onboardingDesc3',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeAnimations();
    _startInitialAnimations();
  }

  void _initializeAnimations() {
    _containerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _containerSlideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _containerController,
      curve: Curves.easeOutCubic,
    ));

    _containerOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _containerController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    _titleOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));

    _descSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
    ));

    _descOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    ));

    _dotsAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _dotsController,
      curve: Curves.elasticOut,
    ));
  }

  void _startInitialAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _containerController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    _dotsController.forward();
  }

  void _animateToPage(int page) async {
    if (page == _currentPage) return;

    // Animate out current text
    _textController.reverse();

    await Future.delayed(const Duration(milliseconds: 200));

    // Change page
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );

    await Future.delayed(const Duration(milliseconds: 300));

    // Animate in new text
    _textController.forward();
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _animateToPage(_currentPage + 1);
    } else {
      _finishOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _animateToPage(_currentPage - 1);
    }
  }

  void _finishOnboarding() {
    // TODO: Navigate to main app or login screen
    // For now, just show a debug message
    AppRouter.navigateTo(context, AppRouter.login); 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Onboarding terminé !')),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _containerController.dispose();
    _textController.dispose();
    _dotsController.dispose();
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
      body: Stack(
        children: [
          // Background images
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _isLastPage = index == _onboardingData.length - 1;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_onboardingData[index].image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
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
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),

          // Bottom container with content - HAUTEUR REDUITE
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: _containerController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    MediaQuery.of(context).size.height * 0.4 * _containerSlideAnimation.value,
                  ),
                  child: Opacity(
                    opacity: _containerOpacityAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 2), // Padding top réduit de 40 à 32
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 20,
                            offset: Offset(0, -10),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Content with text animations - HAUTEUR REDUITE
                            SizedBox(
                              /* height: 140,  */// Réduit de 200 à 140
                              child: AnimatedBuilder(
                                animation: _textController,
                                builder: (context, child) {
                                  return Column(
                                    children: [
                                      // Title
                                      SlideTransition(
                                        position: _titleSlideAnimation,
                                        child: FadeTransition(
                                          opacity: _titleOpacityAnimation,
                                          child: Text(
                                            _getLocalizedText(_onboardingData[_currentPage].title),
                                            style: AppFonts.coiny(
                                              fontSize: 26, // Légèrement réduit de 28 à 26
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textPrimary,
                                              height: 1.2,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 16), // Réduit de 20 à 16

                                      // Description
                                      SlideTransition(
                                        position: _descSlideAnimation,
                                        child: FadeTransition(
                                          opacity: _descOpacityAnimation,
                                          child: Text(
                                            _getLocalizedText(_onboardingData[_currentPage].description),
                                            style: AppFonts.urbanist(
                                              fontSize: 15, // Légèrement réduit de 16 à 15
                                              color: AppColors.textSecondary,
                                              height: 1.4, // Réduit de 1.5 à 1.4
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 32), // Réduit de 40 à 32

                            // Page indicators and navigation
                            AnimatedBuilder(
                              animation: _dotsController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _dotsAnimation.value,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Back button
                                      _currentPage > 0
                                          ? TextButton(
                                              onPressed: _previousPage,
                                              child: Text(
                                                AppLocalizationsHelper.back(context),
                                                style: AppFonts.buttonText.copyWith(
                                                  color: AppColors.textSecondary,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(width: 80),

                                      // Page indicators - DESIGN AMELIORE
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.9),
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 10,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: List.generate(
                                            _onboardingData.length,
                                            (index) => _buildDot(index),
                                          ),
                                        ),
                                      ),

                                      // Next/Finish button
                                      Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          gradient: AppColors.primaryGradient,
                                          borderRadius: BorderRadius.circular(24),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primary.withOpacity(0.3),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(24),
                                            onTap: _nextPage,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    _isLastPage
                                                        ? AppLocalizationsHelper.finish(context)
                                                        : AppLocalizationsHelper.next(context),
                                                    style: AppFonts.buttonText.copyWith(
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Icon(
                                                    Icons.arrow_forward,
                                                    color: AppColors.white,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 16), // Réduit de 20 à 16
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Skip button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 24,
            child: TextButton(
              onPressed: _finishOnboarding,
              child: Text(
                AppLocalizationsHelper.skip(context),
                style: AppFonts.buttonText.copyWith(
                  color: AppColors.white.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // NOUVEAUX INDICATEURS PLUS ESTHETIQUES
  Widget _buildDot(int index) {
    bool isActive = _currentPage == index;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: isActive ? 28 : 8, // Dots actifs plus longs
      height: 8,
      decoration: BoxDecoration(
        gradient: isActive 
          ? AppColors.primaryGradient // Gradient pour le dot actif
          : null,
        color: isActive 
          ? null 
          : AppColors.grey300.withOpacity(0.6), // Dots inactifs plus transparents
        borderRadius: BorderRadius.circular(6),
        boxShadow: isActive ? [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: isActive ? Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.transparent,
              Colors.black.withOpacity(0.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ) : null,
    );
  }

  String _getLocalizedText(String key) {
    switch (key) {
      case 'onboardingTitle1':
        return AppLocalizationsHelper.onboardingTitle1(context);
      case 'onboardingDesc1':
        return AppLocalizationsHelper.onboardingDesc1(context);
      case 'onboardingTitle2':
        return AppLocalizationsHelper.onboardingTitle2(context);
      case 'onboardingDesc2':
        return AppLocalizationsHelper.onboardingDesc2(context);
      case 'onboardingTitle3':
        return AppLocalizationsHelper.onboardingTitle3(context);
      case 'onboardingDesc3':
        return AppLocalizationsHelper.onboardingDesc3(context);
      default:
        return key;
    }
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}