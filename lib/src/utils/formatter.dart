import 'dart:math';

import 'package:flutter/services.dart';

class Formatter extends TextInputFormatter {
  const Formatter({this.asFixed = 1});

  final int asFixed;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = newValue.text.replaceAll(RegExp(r'\D'), '');
    var text =
        (double.parse(value) / pow(10, asFixed)).toStringAsFixed(asFixed);
    return TextEditingValue(text: text);
  }
}
