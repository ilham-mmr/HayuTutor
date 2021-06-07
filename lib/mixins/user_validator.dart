mixin UserValidator {
  String validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String validatePassword(String value) {
    if (value.length < 4) {
      return 'Password must be more than 4 characters';
    }
    return null;
  }

  String validateFullName(String value) {
    if (value.isEmpty || value == '') {
      return 'Full Name must not be empty';
    }
    return null;
  }
}
