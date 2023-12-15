import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      displaySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        color: Colors.black,

        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w400,
      ),
    ));

ThemeData darkTheme = ThemeData(
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      displaySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,

        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w400,
      ),
    ),
    useMaterial3: true,
    colorScheme: darkColorScheme);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.red,
  onPrimary: Colors.white,
  primaryContainer: Color(0xFF936BD4),
  onPrimaryContainer: Color(0xFF21005D),
  secondary: Color(0xFFCCC2DC),
  onSecondary: Color(0xFF332D41),
  // secondaryContainer: Color(0xFFE8DEF8),
  // onSecondaryContainer: Color(0xFF1D192B),
  // tertiary: Color(0xFF7D5260),
  // onTertiary: Color(0xFFFFFFFF),
  // tertiaryContainer: Color(0xFFFFD8E4),
  // onTertiaryContainer: Color(0xFF31111D),
  error: Color(0xFFB3261E),
  onError: Color(0xFFFFFFFF),
  // errorContainer: Color(0xFFF9DEDC),
  // onErrorContainer: Color(0xFF410E0B),
  // outline: Color(0xFF79747E),
  background: Color(0xFFFFFBFE),
  onBackground: Color(0xFF1C1B1F),
  surface: Color(0xFFFFFBFE),
  onSurface: Color(0xFF1C1B1F),
  // surfaceVariant: Color(0xFFE7E0EC),
  // onSurfaceVariant: Color(0xFF49454F),
  // inverseSurface: Color(0xFF313033),
  // onInverseSurface: Color(0xFFF4EFF4),
  // inversePrimary: Color(0xFFD0BCFF),
  // shadow: Color(0xFF000000),
  // surfaceTint: Color(0xFF6750A4),
  // outlineVariant: Color(0xFFCAC4D0),
  // scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.purple,
  onPrimary: Color(0xFFAF9BE0),
  primaryContainer: Color(0xFF4F378B),
  onPrimaryContainer: Color(0xFFEADDFF),
  secondary: Color(0xFFCCC2DC),
  onSecondary: Color(0xFF332D41),
  // secondaryContainer: Color(0xFF4A4458),
  // onSecondaryContainer: Color(0xFFE8DEF8),
  // tertiary: Color(0xFFEFB8C8),
  // onTertiary: Color(0xFF492532),
  // tertiaryContainer: Color(0xFF633B48),
  // onTertiaryContainer: Color(0xFFFFD8E4),
  error: Color(0xFFF2B8B5),
  onError: Color(0xFF601410),
  // errorContainer: Color(0xFF8C1D18),
  // onErrorContainer: Color(0xFFF9DEDC),
  // outline: Color(0xFF938F99),
  background: Colors.black,
  onBackground: Color(0xFFDAC6D6),
  surface: Colors.black45,
  onSurface: Color(0xFFF3C1EE),
  // surfaceVariant: Color(0xFF49454F),
  // onSurfaceVariant: Color(0xFFCAC4D0),
  // inverseSurface: Color(0xFFE6E1E5),
  // onInverseSurface: Color(0xFF313033),
  // inversePrimary: Color(0xFF6750A4),
  // shadow: Color(0xFF000000),
  // surfaceTint: Color(0xFFD0BCFF),
  // outlineVariant: Color(0xFF49454F),
  // scrim: Color(0xFF000000),
);
