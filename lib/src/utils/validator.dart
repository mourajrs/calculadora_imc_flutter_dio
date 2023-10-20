typedef StringFunctionCallback = String? Function(String?)?;

class Validator {
  const Validator._();

  static StringFunctionCallback notLessThen(
    String error, {
    double minimumValue = 1.0,
  }) {
    return (value) {
      if (double.parse(value ?? '0') < minimumValue) {
        return error;
      }
      return null;
    };
  }
}
