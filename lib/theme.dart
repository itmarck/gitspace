import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  hintColor: Colors.white24,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Color(0xFFC73966),
    onPrimary: Colors.white,
    background: Color(0xFF212429),
    onBackground: Colors.white,
    surface: Color(0xFF2E3035),
    surfaceTint: Colors.transparent,
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.white24),
    headlineLarge: TextStyle(fontWeight: FontWeight.bold),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xFF212429),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white24,
      fontWeight: FontWeight.normal,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    ),
  ),
);
