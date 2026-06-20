import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/auth_choice_page.dart';
import '../../features/auth/presentation/pages/phone_login_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/email_login_page.dart';
import '../../features/auth/presentation/pages/email_signup_page.dart';
import '../../app.dart';

/// AppRouter - Defines every "address" (route) in the app and which
/// screen lives at that address.
///
/// WHY go_router INSTEAD OF Navigator.push() EVERYWHERE:
/// go_router treats navigation like URLs (e.g., /login, /otp-verify).
/// This makes deep linking possible later (e.g., an SMS could contain
/// a link that opens the app directly to a specific screen), and
/// keeps all your navigation logic in ONE file instead of scattered
/// across every screen.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth-choice',
        builder: (context, state) => const AuthChoicePage(),
      ),
      GoRoute(
        path: '/phone-login',
        builder: (context, state) => const PhoneLoginPage(),
      ),
      GoRoute(
        path: '/otp-verify',
        builder: (context, state) {
          // Extra data (verificationId, phoneNumber) is passed via
          // the 'extra' parameter when navigating to this route.
          final extra = state.extra as Map<String, String>;
          return OtpVerificationPage(
            verificationId: extra['verificationId']!,
            phoneNumber: extra['phoneNumber']!,
          );
        },
      ),
      GoRoute(
        path: '/email-login',
        builder: (context, state) => const EmailLoginPage(),
      ),
      GoRoute(
        path: '/email-signup',
        builder: (context, state) => const EmailSignupPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const _TemporaryHomePage(),
      ),
    ],
  );
}

/// Temporary placeholder - will be replaced with the real Home
/// screen starting Phase 4 (Period Tracking Module).
class _TemporaryHomePage extends StatelessWidget {
  const _TemporaryHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text(
          'Welcome! You are logged in.\n(Real home page coming in Phase 4)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}