import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Orange App
  static const Color primary = Color(0xFFF69000); // Orange
  static const Color primaryDark = Color(0xFFE67E00);
  static const Color primaryLight = Color(0xFFF9B54D);

  // Secondary Colors
  static const Color secondary = Color(0xFFD3E3FF); // Secondary
  static const Color secondaryDark = Color(0xFFB3D1FF);
  static const Color secondaryLight = Color(0xFFE9F1FF);

  // Card Colors
  static const Color orangeCard = Color(0xFFFFF4E5); // Orange card background

  // Status Colors
  static const Color success = Color(0xFF10B981); // Vert
  static const Color warning = Color(0xFFF59E0B); // Jaune
  static const Color error = Color(0xFFEF4444); // Rouge
  static const Color info = Color(0xFF06B6D4); // Cyan

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9CA3AF); // General grey
  static const Color lightGrey = Color(0xFFF3F4F6); // Light grey background
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // Feedback Type Colors
  static const Color appreciation = Color(0xFFF69000); // Orange primary
  static const Color incident = Color(0xFFEF4444); // Rouge
  static const Color suggestion = Color(0xFF3B82F6); // Bleu

  // Background Colors
  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F4F6);

  // Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF9CA3AF);

  // Border Colors
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderFocused = Color(0xFF3B82F6);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}