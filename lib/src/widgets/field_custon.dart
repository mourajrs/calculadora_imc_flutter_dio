import 'package:flutter/material.dart';

import '../utils/formatter.dart';
import '../utils/validator.dart';

class FieldCuston extends StatelessWidget {
  const FieldCuston({
    super.key,
    this.controller,
    this.label,
    this.formatter,
    this.validator,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController? controller;
  final String? label;
  final List<Formatter>? formatter;
  final StringFunctionCallback validator;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      textInputAction: textInputAction,
      inputFormatters: formatter,
      autofocus: true,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        label: Text(label ?? 'label'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
