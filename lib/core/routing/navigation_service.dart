import 'package:flutter/material.dart';
import 'app_router.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  // Basic navigation methods
  static Future<T?> navigateTo<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    if (context != null) {
      return Navigator.pushNamed<T>(
        context!,
        routeName,
        arguments: arguments,
      );
    }
    return null;
  }

  static Future<T?> navigateAndReplace<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    if (context != null) {
      return Navigator.pushReplacementNamed<T, TO>(
        context!,
        routeName,
        arguments: arguments,
      );
    }
    return null;
  }

  static Future<T?> navigateAndClearStack<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    if (context != null) {
      return Navigator.pushNamedAndRemoveUntil<T>(
        context!,
        routeName,
        (route) => false,
        arguments: arguments,
      );
    }
    return null;
  }

  static void goBack<T extends Object?>([T? result]) {
    if (context != null && Navigator.canPop(context!)) {
      Navigator.pop(context!, result);
    }
  }

  static bool canGoBack() {
    if (context != null) {
      return Navigator.canPop(context!);
    }
    return false;
  }

  // Specific navigation methods for common flows
  static Future<void> goToLogin() async {
    await navigateAndReplace(AppRouter.login);
  }

  static Future<void> goToRegister() async {
    await navigateTo(AppRouter.register);
  }

  static Future<void> goToHome() async {
    await navigateAndClearStack(AppRouter.home);
  }

  static Future<void> goToOnboarding() async {
    await navigateAndReplace(AppRouter.onboarding);
  }

  static Future<void> goToQRScanner() async {
    await navigateTo(AppRouter.qrScanner);
  }

  static Future<void> goToFeedbackForm({
    String? companyId,
    String? serviceId,
    String? employeeId,
  }) async {
    await navigateTo(
      AppRouter.feedbackForm,
      arguments: {
        'companyId': companyId,
        'serviceId': serviceId,
        'employeeId': employeeId,
      },
    );
  }

  static Future<void> goToFeedbackSuccess() async {
    await navigateAndReplace(AppRouter.feedbackSuccess);
  }

  static Future<void> goToRewards() async {
    await navigateTo(AppRouter.rewards);
  }

  static Future<void> goToRewardDetail(String rewardId) async {
    await navigateTo(
      AppRouter.rewardDetail,
      arguments: {'rewardId': rewardId},
    );
  }

  static Future<void> goToProfile() async {
    await navigateTo(AppRouter.profile);
  }

  static Future<void> goToSettings() async {
    await navigateTo(AppRouter.settings);
  }

  static Future<void> goToLanguageSettings() async {
    await navigateTo(AppRouter.language);
  }

  static Future<void> showError(String message) async {
    await navigateTo(
      AppRouter.error,
      arguments: {'message': message},
    );
  }

  // Dialog helpers
  static Future<bool?> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'Confirmer',
    String cancelText = 'Annuler',
  }) async {
    if (context == null) return null;

    return showDialog<bool>(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showInfoDialog({
    required String title,
    required String message,
    String buttonText = 'OK',
  }) async {
    if (context == null) return;

    return showDialog<void>(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  static void showSnackBar({
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (context == null) return;

    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        duration: duration,
      ),
    );
  }

  // Loading helpers
  static void showLoadingDialog() {
    if (context == null) return;

    showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static void hideLoadingDialog() {
    if (context != null && Navigator.canPop(context!)) {
      Navigator.pop(context!);
    }
  }
}