import 'package:flutter/material.dart';

class RMTheme {
  static ColorScheme get lightColorScheme {
    return ColorScheme.light(
      primary: const Color.fromRGBO(94, 98, 239, 1),
      brightness: Brightness.light,
      surface: Colors.white,
      surfaceContainer: Colors.grey.shade200,
      surfaceContainerHigh: Colors.grey.shade300,
      onSurface: Colors.black,
      onSurfaceVariant: Colors.grey.shade900,
      inverseSurface: Colors.black,
      shadow: Colors.white,
      surfaceBright: Colors.grey.shade100,
      surfaceDim: Colors.grey.shade600,
    );
  }

  static ColorScheme get darkColorScheme {
    return ColorScheme.light(
      primary: const Color.fromARGB(255, 100, 105, 255),
      brightness: Brightness.dark,
      surface: Colors.grey.shade900,
      surfaceContainer: const Color.fromARGB(255, 48, 48, 48),
      surfaceContainerHigh: Colors.grey.shade700,
      onSurface: Colors.white,
      onSurfaceVariant: Colors.grey,
      inverseSurface: Colors.white,
      shadow: Colors.grey.shade900,
      surfaceBright: Colors.grey.shade800,
      surfaceDim: Colors.black,
    );
  }

  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
      colorScheme: isDarkTheme ? darkColorScheme : lightColorScheme,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      primaryColor: isDarkTheme
          ? Colors.grey.shade900
          : const Color.fromRGBO(94, 98, 239, 1),
      scaffoldBackgroundColor:
          isDarkTheme ? Colors.grey.shade900 : Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme ? Colors.grey.shade900 : Colors.white,
        foregroundColor: isDarkTheme ? Colors.white : Colors.black,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        centerTitle: true,
      ),
      fontFamily: 'Inter',
    );
  }
}
