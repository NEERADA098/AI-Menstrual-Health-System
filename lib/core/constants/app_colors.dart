import 'package:flutter/material.dart';

/// AppColors - Central color registry for the entire application.
/// 
/// Design Philosophy:
/// - Warm rose tones convey care and health without clinical coldness
/// - Purple accents represent intelligence (AI features)
/// - Green signals safety and success (IoT safe states)
/// - High contrast ratios ensure accessibility for rural users
///   with lower-quality screens
class AppColors {
  // Private constructor - no one can create an instance of AppColors
  // This is called a "utility class" pattern
  AppColors._();

  // ── PRIMARY PALETTE ────────────────────────────────────────────
  /// Primary brand color - Warm rose, represents health and care
  static const Color primary = Color(0xFFE91E8C);
  
  /// Slightly darker shade for pressed states
  static const Color primaryDark = Color(0xFFC2185B);
  
  /// Very light shade for backgrounds and highlights
  static const Color primaryLight = Color(0xFFFCE4EC);

  // ── SECONDARY PALETTE ──────────────────────────────────────────
  /// Secondary color - Deep purple, represents AI intelligence
  static const Color secondary = Color(0xFF6A1B9A);
  
  /// Light secondary for backgrounds
  static const Color secondaryLight = Color(0xFFF3E5F5);

  // ── SEMANTIC COLORS ────────────────────────────────────────────
  /// Success - Safe incinerator state, successful sync
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFFE8F5E9);
  
  /// Warning - Irregular cycle detection, low supply
  static const Color warning = Color(0xFFF57F17);
  static const Color warningLight = Color(0xFFFFF8E1);
  
  /// Error - Critical health alerts, IoT failure
  static const Color error = Color(0xFFC62828);
  static const Color errorLight = Color(0xFFFFEBEE);
  
  /// Info - Educational content, chatbot responses
  static const Color info = Color(0xFF01579B);
  static const Color infoLight = Color(0xFFE1F5FE);

  // ── NEUTRAL PALETTE ────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // ── FEATURE-SPECIFIC COLORS ────────────────────────────────────
  /// Used in cycle calendar - current period days
  static const Color periodDay = Color(0xFFE91E8C);
  
  /// Used in cycle calendar - predicted period days
  static const Color predictedPeriodDay = Color(0xFFF48FB1);
  
  /// Used in cycle calendar - fertile window
  static const Color fertileWindow = Color(0xFF80DEEA);
  
  /// Used in cycle calendar - ovulation day
  static const Color ovulationDay = Color(0xFF00BCD4);
  
  /// IoT - Safe temperature range
  static const Color iotSafe = Color(0xFF4CAF50);
  
  /// IoT - Warning temperature range
  static const Color iotWarning = Color(0xFFFF9800);
  
  /// IoT - Danger - automatic shutdown triggered
  static const Color iotDanger = Color(0xFFF44336);

  // ── GRADIENT DEFINITIONS ───────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE91E8C), Color(0xFF6A1B9A)],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFCE4EC), Color(0xFFFFFFFF)],
  );
}