/// Validators - Input validation functions for all form fields.
/// 
/// These are used in TextFormField's `validator` parameter.
/// They return null if valid, or an error string if invalid.
/// 
/// Critical for:
/// - User registration (auth module)
/// - Health data entry (accurate AI predictions need clean data)
/// - ASHA worker data collection forms
class AppValidators {
  AppValidators._();

  /// Validates email format
  /// Example: "neerada@example.com" ✓ | "neerada@" ✗
  static String? email(String? value) {
    // Check if the field is empty
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    
    // Regular expression for valid email format
    // ^ = start, $ = end
    // [^@]+ = one or more characters that are NOT @
    // \. = a literal dot
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    
    return null; // null means VALID
  }

  /// Validates password strength
  /// Minimum: 8 chars, 1 uppercase, 1 number
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    
    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    // Check for at least one digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    return null;
  }

  /// Validates that password and confirm password match
  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  /// Validates Indian phone number (10 digits)
  static String? phoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove spaces and dashes
    final cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');
    
    // Indian mobile numbers: 10 digits, starting with 6-9
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');
    
    if (!phoneRegex.hasMatch(cleaned)) {
      return 'Enter a valid 10-digit mobile number';
    }
    
    return null;
  }

  /// Validates cycle length (menstrual)
  /// Medically valid range: 21-35 days
  /// Outside this range, the AI should flag for PCOS/irregular cycle
  static String? cycleLength(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Cycle length is required';
    }
    
    final length = int.tryParse(value.trim());
    
    if (length == null) {
      return 'Enter a valid number';
    }
    
    if (length < 15 || length > 60) {
      return 'Please enter a value between 15 and 60 days';
    }
    
    // Medical note: 21-35 is "normal", but we allow wider range
    // and let the AI model determine if it's irregular
    
    return null;
  }

  /// Validates period duration
  /// Medical range: 2-7 days typically
  static String? periodDuration(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Period duration is required';
    }
    
    final days = int.tryParse(value.trim());
    
    if (days == null) {
      return 'Enter a valid number';
    }
    
    if (days < 1 || days > 10) {
      return 'Please enter a value between 1 and 10 days';
    }
    
    return null;
  }

  /// Validates age
  /// App targets: 12+ years old (adolescent girls + women)
  static String? age(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Age is required';
    }
    
    final age = int.tryParse(value.trim());
    
    if (age == null) {
      return 'Enter a valid age';
    }
    
    if (age < 10 || age > 60) {
      return 'Please enter a valid age';
    }
    
    return null;
  }

  /// Required field validator (for any mandatory field)
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates OTP (6-digit numeric code)
  static String? otp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'OTP is required';
    }
    
    if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
      return 'Enter the 6-digit OTP';
    }
    
    return null;
  }
}