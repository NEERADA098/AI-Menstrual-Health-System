import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// PhoneLoginPage - Where the user enters their phone number.
class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  // GlobalKey lets us trigger form validation and access form state
  // from outside the widget tree (e.g., inside an onPressed callback)
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    // CRITICAL: Always dispose controllers to prevent memory leaks.
    // Without this, the controller stays in memory forever even
    // after this screen is closed.
    _phoneController.dispose();
    super.dispose();
  }

  void _submitPhone() {
    // validate() runs every validator function attached to every
    // TextFormField inside this Form, and returns true only if
    // ALL of them pass (return null).
    if (_formKey.currentState!.validate()) {
      // Indian phone numbers need +91 prefix for Firebase E.164 format
      final fullPhoneNumber = '+91${_phoneController.text.trim()}';

      context.read<AuthBloc>().add(
            AuthPhoneOtpRequested(fullPhoneNumber),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // BlocListener for SIDE EFFECTS (navigation, snackbars) -
    // does NOT rebuild this widget's UI.
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpSent) {
          context.go('/otp-verify', extra: {
            'verificationId': state.verificationId,
            'phoneNumber': state.phoneNumber,
          });
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/auth-choice'),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Enter Your Phone Number',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "We'll send you a 6-digit code to verify it's you",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: AppValidators.phoneNumber,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '9876543210',
                      prefixText: '+91  ',
                      prefixIcon: Icon(Icons.phone_android),
                      counterText: '', // hides the "0/10" counter
                    ),
                  ),
                  const SizedBox(height: 32),

                  // BlocBuilder DOES rebuild - we use it here to
                  // show a loading spinner inside the button while
                  // the OTP is being sent.
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return ElevatedButton(
                        onPressed: isLoading ? null : _submitPhone,
                        child: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Send OTP'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}