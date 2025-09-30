import 'package:flutter/material.dart';
import 'package:qualywatchmobile/core/constants/app_colors.dart';
import 'package:qualywatchmobile/core/constants/app_fonts.dart';
import 'package:qualywatchmobile/core/routing/app_router.dart';

class RegisterPage0Horizontal extends StatefulWidget {
  const RegisterPage0Horizontal({Key? key}) : super(key: key);

  @override
  State<RegisterPage0Horizontal> createState() =>
      _RegisterPage0HorizontalState();
}

class _RegisterPage0HorizontalState extends State<RegisterPage0Horizontal>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _progressController;

  final List<StoryStep> _steps = [
    StoryStep(
      title: 'Vos Informations',
      description:
          'Créez votre profil gérant avec vos informations personnelles',
      icon: Icons.person_rounded,
      color: AppColors.primary,
      features: [
        'Nom et prénom',
        'Email et téléphone',
        'Mot de passe sécurisé',
      ],
    ),
    StoryStep(
      title: 'Votre Entreprise',
      description: 'Parlez-nous de votre établissement et de votre activité',
      icon: Icons.business_center_rounded,
      color: const Color(0xFF4CAF50),
      features: [
        'Nom de l\'entreprise',
        'Catégorie d\'activité',
        'Localisation',
      ],
    ),
    StoryStep(
      title: 'Photos & Logo',
      description: 'Ajoutez une touche visuelle pour compléter votre profil',
      icon: Icons.photo_camera_rounded,
      color: const Color(0xFFFF9800),
      features: [
        'Photo de l\'établissement',
        'Logo du gérant',
        'Validation finale',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        if (_progressController.isCompleted) {
          _nextPage();
        }
      });

    _progressController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      _progressController.reset();
      _progressController.forward();
    } else {
      _startRegistration();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      _progressController.reset();
      _progressController.forward();
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _startRegistration() {
    Navigator.pushReplacementNamed(context, AppRouter.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: GestureDetector(
        onTapUp: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            _previousPage();
          } else {
            _nextPage();
          }
        },
        child: Stack(
          children: [
            // Page Content
            PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                return _buildStoryPage(_steps[index]);
              },
            ),

            // Top Progress Bars
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProgressBars(),
                    const SizedBox(height: 16),
                    _buildTopBar(),
                  ],
                ),
              ),
            ),

            // Skip Button (bottom right)
            Positioned(
              bottom: 40,
              right: 24,
              child: _buildSkipButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBars() {
    return Row(
      children: List.generate(_steps.length, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index < _steps.length - 1 ? 4 : 0,
            ),
            child: AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                double progress = 0.0;
                if (index < _currentPage) {
                  progress = 1.0;
                } else if (index == _currentPage) {
                  progress = _progressController.value;
                }

                return ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 3,
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          '${_currentPage + 1}/${_steps.length}',
          style: AppFonts.urbanist(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStoryPage(StoryStep step) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            step.color,
            step.color.withOpacity(0.7),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Icon with animation
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    step.icon,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Title
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  step.title,
                  style: AppFonts.luckiestGuy(
                    fontSize: 36,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),

              // Description
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  step.description,
                  style: AppFonts.urbanist(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 40),

              // Features List
              ...step.features.asMap().entries.map((entry) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 1200 + (entry.key * 100)),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(30 * (1 - value), 0),
                        child: child,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: AppFonts.urbanist(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return GestureDetector(
      onTap: _startRegistration,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _currentPage == _steps.length - 1 ? 'Commencer' : 'Passer',
              style: AppFonts.urbanist(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class StoryStep {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> features;

  StoryStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.features,
  });
}