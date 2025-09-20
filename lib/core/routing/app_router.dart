import 'package:flutter/material.dart';
import '../../presentation/pages/splash_screen.dart';
import '../../presentation/pages/start_screen.dart';
import '../../presentation/pages/onboarding_screen.dart';
// TODO: Import other screens as they are created
// import '../../presentation/pages/auth/login_screen.dart';
// import '../../presentation/pages/auth/register_screen.dart';
// import '../../presentation/pages/home/home_screen.dart';
// import '../../presentation/pages/qr/qr_scanner_screen.dart';
// import '../../presentation/pages/feedback/feedback_screen.dart';

class AppRouter {
  // Route names
  static const String splash = '/';
  static const String start = '/start';
  static const String onboarding = '/onboarding';

  // Auth routes
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyEmail = '/auth/verify-email';

  // Main app routes
  static const String home = '/home';
  static const String dashboard = '/dashboard';

  // QR & Feedback routes
  static const String qrScanner = '/qr-scanner';
  static const String feedback = '/feedback';
  static const String feedbackForm = '/feedback/form';
  static const String feedbackSuccess = '/feedback/success';

  // Rewards routes
  static const String rewards = '/rewards';
  static const String rewardDetail = '/rewards/detail';
  static const String redeemReward = '/rewards/redeem';

  // Profile routes
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String settings = '/settings';
  static const String language = '/settings/language';
  static const String notifications = '/settings/notifications';
  static const String about = '/about';

  // Error routes
  static const String notFound = '/404';
  static const String error = '/error';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Initial flow routes
      case splash:
        return _createRoute(
          const SplashScreen(),
          settings: settings,
          transitionType: RouteTransitionType.fade,
        );

      case start:
        return _createRoute(
          const StartScreen(),
          settings: settings,
          transitionType: RouteTransitionType.fade,
          duration: const Duration(milliseconds: 800),
        );

      case onboarding:
        return _createRoute(
          const OnboardingScreen(),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
          duration: const Duration(milliseconds: 800),
        );

      // Auth routes
      case login:
        return _createRoute(
          _buildPlaceholderScreen('Login Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromBottom,
        );

      case register:
        return _createRoute(
          _buildPlaceholderScreen('Register Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      case forgotPassword:
        return _createRoute(
          _buildPlaceholderScreen('Forgot Password Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      case verifyEmail:
        return _createRoute(
          _buildPlaceholderScreen('Verify Email Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      // Main app routes
      case home:
        return _createRoute(
          _buildPlaceholderScreen('Home Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      case dashboard:
        return _createRoute(
          _buildPlaceholderScreen('Dashboard Screen'),
          settings: settings,
          transitionType: RouteTransitionType.fade,
        );

      // QR & Feedback routes
      case qrScanner:
        return _createRoute(
          _buildPlaceholderScreen('QR Scanner Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromBottom,
        );

      case feedback:
        return _createRoute(
          _buildPlaceholderScreen('Feedback List Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      case feedbackForm:
        final args = settings.arguments as Map<String, dynamic>?;
        return _createRoute(
          _buildPlaceholderScreen('Feedback Form Screen', args: args),
          settings: settings,
          transitionType: RouteTransitionType.slideFromBottom,
        );

      case feedbackSuccess:
        return _createRoute(
          _buildPlaceholderScreen('Feedback Success Screen'),
          settings: settings,
          transitionType: RouteTransitionType.scale,
        );

      // Rewards routes
      case rewards:
        return _createRoute(
          _buildPlaceholderScreen('Rewards Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      case rewardDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return _createRoute(
          _buildPlaceholderScreen('Reward Detail Screen', args: args),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      case redeemReward:
        final args = settings.arguments as Map<String, dynamic>?;
        return _createRoute(
          _buildPlaceholderScreen('Redeem Reward Screen', args: args),
          settings: settings,
          transitionType: RouteTransitionType.slideFromBottom,
        );

      // Profile routes
      case profile:
        return _createRoute(
          _buildPlaceholderScreen('Profile Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      case editProfile:
        return _createRoute(
          _buildPlaceholderScreen('Edit Profile Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      /* case settings:
        return _createRoute(
          _buildPlaceholderScreen('Settings Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        ); */

      case language:
        return _createRoute(
          _buildPlaceholderScreen('Language Settings Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      case notifications:
        return _createRoute(
          _buildPlaceholderScreen('Notification Settings Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      case about:
        return _createRoute(
          _buildPlaceholderScreen('About Screen'),
          settings: settings,
          transitionType: RouteTransitionType.slideFromRight,
        );

      // Error routes
      case notFound:
        return _createRoute(
          _buildErrorScreen('Page not found', '404'),
          settings: settings,
          transitionType: RouteTransitionType.fade,
        );

      case error:
        final args = settings.arguments as Map<String, dynamic>?;
        final message = args?['message'] ?? 'An error occurred';
        return _createRoute(
          _buildErrorScreen(message, 'Error'),
          settings: settings,
          transitionType: RouteTransitionType.fade,
        );

      default:
        return _createRoute(
          _buildErrorScreen('Route not found: ${settings.name}', '404'),
          settings: settings,
          transitionType: RouteTransitionType.fade,
        );
    }
  }

  static Route<T> _createRoute<T extends Object?>(
    Widget page, {
    required RouteSettings settings,
    RouteTransitionType transitionType = RouteTransitionType.slideFromRight,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    switch (transitionType) {
      case RouteTransitionType.fade:
        return PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: duration,
          settings: settings,
        );

      case RouteTransitionType.slideFromRight:
        return PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
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
          transitionDuration: duration,
          settings: settings,
        );

      case RouteTransitionType.slideFromLeft:
        return PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
          transitionDuration: duration,
          settings: settings,
        );

      case RouteTransitionType.slideFromBottom:
        return PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
          transitionDuration: duration,
          settings: settings,
        );

      case RouteTransitionType.slideFromTop:
        return PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
          transitionDuration: duration,
          settings: settings,
        );

      case RouteTransitionType.scale:
        return PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          transitionDuration: duration,
          settings: settings,
        );

      case RouteTransitionType.rotation:
        return PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return RotationTransition(
              turns: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          transitionDuration: duration,
          settings: settings,
        );

      default:
        return MaterialPageRoute<T>(
          builder: (_) => page,
          settings: settings,
        );
    }
  }

  // Helper method to build placeholder screens during development
  static Widget _buildPlaceholderScreen(String title, {Map<String, dynamic>? args}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Coming Soon...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            if (args != null) ...[
              const SizedBox(height: 16),
              Text(
                'Arguments: ${args.toString()}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper method to build error screens
  static Widget _buildErrorScreen(String message, String title) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate back or to home
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  // Navigation helper methods
  static Future<T?> navigateTo<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> navigateAndReplace<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed<T, TO>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> navigateAndClearStack<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  static void goBack(BuildContext context, [Object? result]) {
    Navigator.pop(context, result);
  }

  static bool canGoBack(BuildContext context) {
    return Navigator.canPop(context);
  }
}

enum RouteTransitionType {
  fade,
  slideFromRight,
  slideFromLeft,
  slideFromBottom,
  slideFromTop,
  scale,
  rotation,
}