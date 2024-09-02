import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF416FDF),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF6EAEE7),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  background: Color(0xFFFCFDF6),
  onBackground: Color(0xFF1A1C18),
  shadow: Color(0xFF000000),
  outlineVariant: Color(0xFFC2C8BC),
  surface: Color(0xFFF9FAF3),
  onSurface: Color(0xFF1A1C18),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF1A1C18), // Dark primary color
  onPrimary: Color(0xFFFFFFFF), // White text color on primary background
  secondary: Color(0xFF3B3F4E), // Dark secondary color
  onSecondary: Color(0xFFFFFFFF), // White text color on secondary background
  error: Color(0xFFBA1A1A), // Error color
  onError: Color(0xFFFFFFFF), // White text color on error background
  background: Color(0xFF1A1C18), // Dark background color
  onBackground: Color(0xFFC2C8BC), // Light text color on dark background
  shadow: Color(0xFF000000), // Shadow color
  outlineVariant: Color(0xFF3B3F4E), // Dark outline variant color
  surface: Color(0xFF1A1C18), // Dark surface color
  onSurface: Color(0xFFC2C8BC), // Light text color on dark surface
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        lightColorScheme.primary, // Slightly darker shade for the button
      ),
      foregroundColor:
          MaterialStateProperty.all<Color>(Colors.white), // text color
      elevation: MaterialStateProperty.all<double>(5.0), // shadow
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Adjust as needed
        ),
      ),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        darkColorScheme.primary, // Dark primary color for buttons
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        Colors.white, // White text color on buttons
      ),
      elevation: MaterialStateProperty.all<double>(5.0), // Shadow
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Adjust as needed
        ),
      ),
    ),
  ),
);
