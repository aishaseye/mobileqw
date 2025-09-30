import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  // Google Fonts
  static TextStyle coiny({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.coiny(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle courgette({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.courgette(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle urbanist({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.urbanist(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle luckiestGuy({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.luckiestGuy(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Predefined text styles for the app

  // Headers (using Coiny for fun headers)
  static TextStyle get appTitle => coiny(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get onboardingTitle => coiny(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get sectionTitle => coiny(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // Decorative text (using Courgette)
  static TextStyle get decorativeText => courgette(
    fontSize: 18,
  );

  static TextStyle get decorativeSubtitle => courgette(
    fontSize: 16,
  );

  // Body text and UI (using Urbanist)
  static TextStyle get bodyLarge => urbanist(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static TextStyle get bodyMedium => urbanist(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static TextStyle get bodySmall => urbanist(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static TextStyle get buttonText => urbanist(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get captionText => urbanist(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get labelText => urbanist(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  // Specific use cases
  static TextStyle get appBarTitle => urbanist(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get cardTitle => urbanist(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get cardSubtitle => urbanist(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get inputText => urbanist(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get hintText => urbanist(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // Text themes for Material Design
  static TextTheme get textTheme => TextTheme(
    displayLarge: coiny(fontSize: 32, fontWeight: FontWeight.bold),
    displayMedium: coiny(fontSize: 28, fontWeight: FontWeight.w600),
    displaySmall: coiny(fontSize: 24, fontWeight: FontWeight.w600),
    headlineLarge: urbanist(fontSize: 22, fontWeight: FontWeight.w600),
    headlineMedium: urbanist(fontSize: 20, fontWeight: FontWeight.w600),
    headlineSmall: urbanist(fontSize: 18, fontWeight: FontWeight.w600),
    titleLarge: urbanist(fontSize: 16, fontWeight: FontWeight.w600),
    titleMedium: urbanist(fontSize: 14, fontWeight: FontWeight.w500),
    titleSmall: urbanist(fontSize: 12, fontWeight: FontWeight.w500),
    bodyLarge: urbanist(fontSize: 16, fontWeight: FontWeight.normal),
    bodyMedium: urbanist(fontSize: 14, fontWeight: FontWeight.normal),
    bodySmall: urbanist(fontSize: 12, fontWeight: FontWeight.normal),
    labelLarge: urbanist(fontSize: 14, fontWeight: FontWeight.w500),
    labelMedium: urbanist(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: urbanist(fontSize: 10, fontWeight: FontWeight.w500),
  );
}