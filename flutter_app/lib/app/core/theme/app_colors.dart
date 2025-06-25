import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors - Tropical Theme
  static const Color primaryTurquoise = Color(0xFF40E0D0);
  static const Color primaryPink = Color(0xFFFF69B4);
  static const Color primaryPurple = Color(0xFF9370DB);
  
  // Secondary Colors
  static const Color secondaryTeal = Color(0xFF20B2AA);
  static const Color secondaryCoral = Color(0xFFFF7F7F);
  static const Color secondaryLavender = Color(0xFFB19CD9);
  
  // Accent Colors
  static const Color accentOrange = Color(0xFFFFA500);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Neutral Colors
  static const Color neutral100 = Color(0xFFF8FAFC);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);
  
  // Background Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  
  // Text Colors
  static const Color textPrimary = neutral800;
  static const Color textSecondary = neutral600;
  static const Color textTertiary = neutral400;
  static const Color textInverse = Colors.white;
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryTurquoise, primaryPink, primaryPurple],
    stops: [0.0, 0.5, 1.0],
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryTeal, secondaryCoral],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white, neutral100],
  );
}