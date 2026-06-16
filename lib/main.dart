import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'app.dart';

/// main() - The VERY FIRST function Flutter calls when app starts.
/// 
/// Think of this as the "ignition switch" of your car.
/// Before the engine (UI) starts, you need to:
/// 1. Initialize the Flutter engine
/// 2. Set up the translation system
/// 3. Configure the device orientation
/// 4. Set the status bar appearance
/// Then hand control to App() widget
void main() async {
  // ── STEP 1: FLUTTER ENGINE INITIALIZATION ───────────────────────
  // CRITICAL: This MUST be the first line in main() when you use
  // any async operations before runApp()
  // Without this, Flutter will crash with a confusing error
  WidgetsFlutterBinding.ensureInitialized();

  // ── STEP 2: LOCALIZATION INITIALIZATION ─────────────────────────
  // EasyLocalization reads translation files from assets/translations/
  // It detects the device language and loads the right translation file
  await EasyLocalization.ensureInitialized();

  // ── STEP 3: SCREEN ORIENTATION ──────────────────────────────────
  // Lock to portrait only.
  // Reasoning: Menstrual health data (calendar, charts) is complex.
  // Landscape mode makes it harder to read. Many rural phone users
  // hold phones in portrait mode. This ensures consistent layout.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ── STEP 4: STATUS BAR STYLE ────────────────────────────────────
  // The status bar is the top bar showing time, battery, signal.
  // We make it transparent so our gradient backgrounds look full-screen
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,          // No color background
      statusBarIconBrightness: Brightness.dark,    // Dark icons on light bg
      systemNavigationBarColor: Colors.white,       // Bottom nav area
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // ── STEP 5: RUN THE APP ─────────────────────────────────────────
  // EasyLocalization.ensureInitialized must be called before this
  // path: folder containing translation JSON files
  // supportedLocales: languages we support
  // fallbackLocale: if device language isn't supported, use English
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),    // English (United States)
        Locale('ml', 'IN'),    // Malayalam (India) - from Kerala!
        Locale('hi', 'IN'),    // Hindi (India)
        Locale('ta', 'IN'),    // Tamil (India)
        Locale('te', 'IN'),    // Telugu (India)
      ],
      path: 'assets/translations',  // Where translation files are stored
      fallbackLocale: const Locale('en', 'US'),  // Default to English
      child: const App(),    // Our app is the child of the localization wrapper
    ),
  );
}