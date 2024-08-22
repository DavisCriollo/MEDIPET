import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalDigits;

  DecimalTextInputFormatter({this.decimalDigits = 2});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'^\d*\.?\d{0,' + decimalDigits.toString() + '}');
    final newText = newValue.text;

    if (regExp.hasMatch(newText)) {
      return newValue;
    }

    return oldValue;
  }
}