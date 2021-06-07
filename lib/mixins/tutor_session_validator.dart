mixin TutorSessionValidator {
  String validateSubject(String value) {
    if (value.isEmpty || value == '') {
      return 'Subject must not be empty';
    }
    return null;
  }

  String validateDuration(String value) {
    double parsedValue = double.tryParse(value);
    if (value.isEmpty) {
      return 'The duration must not be empty';
    }
    if (parsedValue != null && parsedValue <= 0) {
      return 'The duration should be greater than 0';
    }
    if (parsedValue == null) {
      return 'The duration should a whole number';
    }
    return null;
  }

  String validateLocation(String value) {
    if (value.isEmpty || value == '') {
      return 'Location must not be empty';
    }
    return null;
  }

  String validatePrice(String value) {
    double parsedValue = double.tryParse(value);
    if (value.isEmpty) {
      return 'The price must not be empty';
    }
    if (parsedValue != null && parsedValue <= 0) {
      return 'The price should be greater than 0';
    }
    if (parsedValue == null) {
      return 'The price should a whole number';
    }
    return null;
  }
}
