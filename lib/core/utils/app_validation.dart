abstract class AppValidators {
  AppValidators._();

  static final RegExp _emailRegex = RegExp(r'^[\w.-]+@([\w-]+\.)+[\w-]{2,}$');

  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[#?!@$%^&*-]).{8,}$',
  );

  static final RegExp _nameRegex = RegExp(r'^[a-zA-Z]+$');

  static final RegExp _phoneRegex = RegExp(r'^\+20(10|11|12|15)[0-9]{8}$');

  static String? validateEmail(String? email) {
    final value = email?.trim();

    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    if (!_emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!_passwordRegex.hasMatch(password)) {
      return 'Password must contain uppercase, lowercase, number, and special character';
    }

    return null;
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? validateEmptyTextFormField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    return null;
  }

  static String? validateName(String? value, {required String fieldName}) {
    final name = value?.trim();

    if (name == null || name.isEmpty) {
      return '$fieldName is required';
    }

    if (name.length < 3) {
      return '$fieldName must be at least 3 characters long';
    }

    if (!_nameRegex.hasMatch(name)) {
      return '$fieldName must contain English letters only, without spaces';
    }

    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    final value = phoneNumber?.trim();

    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    if (!_phoneRegex.hasMatch(value)) {
      return 'Please enter a valid Egyptian phone number (+201XXXXXXXXX)';
    }

    return null;
  }
}
