import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData rainbowTheme = ThemeData(
    primarySwatch: Colors.purple,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.indigo),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black87),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.red,
      iconTheme: IconThemeData(color: Colors.yellow),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.orange,
    ),
    cardTheme: CardTheme(
      color: Colors.green[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
        .copyWith(secondary: Colors.orange),
  );
}
