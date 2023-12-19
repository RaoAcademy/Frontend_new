// ignore_for_file: avoid_classes_with_only_static_members

class Validations {
  static String? validate({
    LoopsValidation? type,
    String? value,
    bool? requiredField,
  }) {
    switch (type) {
      case LoopsValidation.requiredField:
        return validateRequired(value!);
      case LoopsValidation.email:
        return validateEmail(value!);
      case LoopsValidation.password:
        return validatePassword(value!);
      case LoopsValidation.name:
        return validateName(value!);
      case LoopsValidation.phoneNumber:
        return validatePhone(value!);
      case LoopsValidation.price:
        return validatePrice(value!);
      case LoopsValidation.numericValue:
        return validateNumeric(value: value, required: requiredField);
      default:
        return null;
    }
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required.';
    }
    final RegExp nameExp = RegExp(r'^[A-za-z ]+$');
    if (nameExp.hasMatch(value) == false) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  static String? validateEmail(String value) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  static String? validateNumeric({String? value, bool? required}) {
    const String pattern = r'^(0|[1-9]\d*)?(\.\d+)?(?<=\d)$';
    final RegExp regex = RegExp(pattern);

    if (value!.isEmpty && !required!) {
      return null;
    } else if (!regex.hasMatch(value)) {
      return 'Only Numbers accepted';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    const String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please choose strong a password.';
    } else {
      return null;
    }
  }

  static String? validateRequired(String value) {
    if (value.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }

  static String? validatePhone(String value) {
    if (value.isEmpty || value.length < 10) {
      return 'Mobile Number must be valid';
    } else {
      return null;
    }
  }

  static String? validatePrice(String value) {
    if (value.isEmpty) {
      return 'Price must be valid';
    } else if (double.parse(value) <= 0) {
      return 'Price must be greater than 0';
    } else {
      return null;
    }
  }
}

enum LoopsValidation {
  requiredField,
  name,
  price,
  numericValue,
  email,
  password,
  phoneNumber,
  none,
}
