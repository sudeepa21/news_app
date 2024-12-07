import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.blue, // Background color for AppBar in light theme
      titleTextStyle: TextStyle(
        color: Colors.white, // Title text color
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white), // Back button/icon color
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black), // Default text
      bodyMedium:
          TextStyle(fontSize: 14, color: Colors.black87), // For subtitles
      titleLarge: TextStyle(fontSize: 16, color: Colors.black), // For titles
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white, // Background color for input fields
      hintStyle: TextStyle(color: Colors.grey), // Placeholder text color
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.blue), // Switch thumb color
      trackColor: MaterialStateProperty.all(
          Colors.blue.withOpacity(0.5)), // Switch track color
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black87, // Background color for AppBar in dark theme
      titleTextStyle: TextStyle(
        color: Colors.white, // Title text color
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white), // Back button/icon color
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white), // Default text
      bodyMedium:
          TextStyle(fontSize: 14, color: Colors.white70), // For subtitles
      titleLarge: TextStyle(fontSize: 16, color: Colors.white), // For titles
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade800, // Background color for input fields
      hintStyle:
          TextStyle(color: Colors.grey.shade400), // Placeholder text color
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor:
          MaterialStateProperty.all(Colors.blueGrey), // Switch thumb color
      trackColor: MaterialStateProperty.all(
          Colors.blueGrey.withOpacity(0.5)), // Switch track color
    ),
  );
}
