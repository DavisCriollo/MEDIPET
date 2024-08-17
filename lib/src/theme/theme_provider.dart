import 'package:flutter/material.dart';
import 'package:neitorcont/src/theme/theme_app.dart';

class ThemeProvider extends ChangeNotifier {
  AppTheme _appTheme = AppTheme.defaultTheme();

  AppTheme get appTheme => _appTheme;

  void setTheme(String? primaryColorHex, String? accentColorHex) {
    final primaryColor = _hexToColor(primaryColorHex) ?? Colors.blue;
    final accentColor = _hexToColor(accentColorHex) ?? Colors.grey;
    _appTheme = AppTheme(primaryColor: primaryColor, accentColor: accentColor);
    notifyListeners();
  }

  Color? _hexToColor(String? hex) {
    if (hex == null || hex.isEmpty) return null;
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}