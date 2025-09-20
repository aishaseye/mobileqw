
import 'package:flutter/material.dart';
import 'package:qualywatchmobile/l10n/app_localizations.dart';

class AppLocalizationsHelper {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  // Helper methods pour un accès plus facile
  static String welcome(BuildContext context) => of(context).welcome;
  static String getStarted(BuildContext context) => of(context).getStarted;
  static String next(BuildContext context) => of(context).next;
  static String skip(BuildContext context) => of(context).skip;
  static String back(BuildContext context) => of(context).back;
  static String finish(BuildContext context) => of(context).finish;

  // Onboarding
  static String onboardingTitle1(BuildContext context) => of(context).onboardingTitle1;
  static String onboardingDesc1(BuildContext context) => of(context).onboardingDesc1;
  static String onboardingTitle2(BuildContext context) => of(context).onboardingTitle2;
  static String onboardingDesc2(BuildContext context) => of(context).onboardingDesc2;
  static String onboardingTitle3(BuildContext context) => of(context).onboardingTitle3;
  static String onboardingDesc3(BuildContext context) => of(context).onboardingDesc3;

  // Actions
  static String scanQrCode(BuildContext context) => of(context).scanQrCode;
  static String giveFeedback(BuildContext context) => of(context).giveFeedback;
  static String earnRewards(BuildContext context) => of(context).earnRewards;

  // Forms
  static String email(BuildContext context) => of(context).email;
  static String password(BuildContext context) => of(context).password;
  static String login(BuildContext context) => of(context).login;
  static String register(BuildContext context) => of(context).register;

  // Navigation
  static String feedback(BuildContext context) => of(context).feedback;
  static String rewards(BuildContext context) => of(context).rewards;
  static String profile(BuildContext context) => of(context).profile;
  static String settings(BuildContext context) => of(context).settings;
  static String language(BuildContext context) => of(context).language;
  static String french(BuildContext context) => of(context).french;
  static String english(BuildContext context) => of(context).english;
}