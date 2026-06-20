import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

/// AuthChoicePage - The "front door" where users pick HOW to log in.
///
/// DESIGN RATIONALE FOR RURAL ACCESSIBILITY:
/// Large, icon-supported buttons rather than a dense form. A rural
/// teenage girl using this for the first time should immediately
/// understand "tap here to use your phone number" without reading
/// dense instructions.
class AuthChoicePage extends StatelessWidget {
  const AuthChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to CycleAI',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Choose how you want to continue',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // ── PHONE LOGIN OPTION (Primary - for most users) ──────
              _AuthOptionCard(
                icon: Icons.phone_android,
                title: 'Continue with Phone Number',
                subtitle: 'Quick and easy - no password needed',
                isPrimary: true,
                onTap: () => context.go('/phone-login'),
              ),
              const SizedBox(height: 16),

              // ── EMAIL LOGIN OPTION (For ASHA workers / admins) ──────
              _AuthOptionCard(
                icon: Icons.email_outlined,
                title: 'Continue with Email',
                subtitle: 'For ASHA workers and administrators',
                isPrimary: false,
                onTap: () => context.go('/email-login'),
              ),

              const Spacer(),

              Center(
                child: TextButton(
                  onPressed: () => context.go('/email-signup'),
                  child: const Text("Don't have an account? Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A large, tappable card representing one login method.
class _AuthOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isPrimary;
  final VoidCallback onTap;

  const _AuthOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isPrimary ? AppColors.primary : AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isPrimary
                ? null
                : Border.all(color: AppColors.grey300),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: isPrimary ? AppColors.white : AppColors.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isPrimary
                            ? AppColors.white
                            : AppColors.grey900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: isPrimary
                            ? AppColors.white.withValues(alpha: 0.85)
                            : AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isPrimary ? AppColors.white : AppColors.grey400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}