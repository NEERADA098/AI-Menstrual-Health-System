import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'injection_container.dart';

/// main() - The VERY FIRST function Flutter calls when app starts.
void main() async {
  // ── STEP 1: FLUTTER ENGINE INITIALIZATION ───────────────────────
  WidgetsFlutterBinding.ensureInitialized();

  // ── STEP 2: FIREBASE INITIALIZATION ─────────────────────────────
  // CRITICAL: Must happen before any Firebase service (Auth, etc.)
  // is used anywhere in the app. DefaultFirebaseOptions comes from
  // the auto-generated firebase_options.dart file.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ── STEP 2.5: DEPENDENCY INJECTION SETUP ────────────────────────
  // Must run AFTER Firebase is initialized (since our datasources
  // depend on FirebaseAuth.instance and FirebaseFirestore.instance
  // already existing), but BEFORE the app widget tree is built
  // (since widgets will immediately request these dependencies).
  await setupInjection();

  // ── STEP 3: LOCALIZATION INITIALIZATION ─────────────────────────
  await EasyLocalization.ensureInitialized();

  // ── STEP 4: SCREEN ORIENTATION ───────────────────────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ── STEP 5: STATUS BAR STYLE ──────────────────────────────────────
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // ── STEP 6: RUN THE APP ────────────────────────────────────────────
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ml', 'IN'),
        Locale('hi', 'IN'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const App(),
    ),
  );
}
