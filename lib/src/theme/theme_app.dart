import 'package:flutter/material.dart';

class AppTheme {
  final Color primaryColor;
  final Color accentColor; // Usamos 'accentColor' que aún es válido en Flutter 2.10.2

  AppTheme({required this.primaryColor, required this.accentColor});

  static AppTheme defaultTheme() {
    return AppTheme(
      primaryColor: Colors.green,
      accentColor: Colors.grey,
    );
  }

  ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      accentColor: accentColor, // Utiliza 'accentColor' en esta versión
       fontFamily: 'Roboto', // Configura la fuente Roboto
      appBarTheme: AppBarTheme(
        color: primaryColor,  // 'color' es el parámetro correcto en esta versión
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: primaryColor, // 'primary' es el parámetro correcto en esta versión
        ),
      ),
    );
  }
}