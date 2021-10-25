class Validations {
  static String? validateName(value) {
    if (value.isEmpty) return 'Username is Required.';
    final RegExp nameExp = new RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  static String? validateNumber(value, [bool isRequried = true]) {
    if (value.isEmpty && isRequried) return 'number is required.';

    final RegExp nameExp = new RegExp(
        r'(([A-Za-z]){2,3}(|-)(?:[0-9]){1,2}(|-)(?:[A-Za-z]){2}(|-)([0-9]){1,4})|(([A-Za-z]){2,3}(|-)([0-9]){1,4})$');
    if (!nameExp.hasMatch(value) && isRequried) return 'Invalid Number';
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty || value.length < 6)
      return 'Please enter a valid password.';
    return null;
  }
}
