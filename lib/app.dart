import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';

/// App - Root widget of the entire application.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SplashScreen(),
    );
  }
}

/// Temporary splash screen for Phase 1
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE91E8C),
              Color(0xFF6A1B9A),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              AppStrings.appName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              AppStrings.appTagline,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 64),
            SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(
                color: Colors.white.withValues(alpha: 0.8),
                strokeWidth: 2.5,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Setting up your health companion...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}