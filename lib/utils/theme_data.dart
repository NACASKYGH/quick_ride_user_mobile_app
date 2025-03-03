import 'app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

TextStyle textStyle = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: AppColors.blackText,
  fontFamily: 'Poppins',
);

ThemeData lightTheme = FlexThemeData.light(
  useMaterial3: true,
  fontFamily: 'Poppins',
  colors: FlexSchemeColor(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    appBarColor: AppColors.lightBg,
    tertiary: AppColors.blackText.withValues(alpha: .1),
  ),
).copyWith(
  scaffoldBackgroundColor:
      AppColors.lightBg, //const Color.fromARGB(255, 245, 246, 253),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightBg,
  ),
  textTheme: TextTheme(
    headlineLarge: textStyle.copyWith(fontSize: 24),
    headlineMedium: textStyle.copyWith(fontSize: 20),
    headlineSmall: textStyle.copyWith(fontSize: 16),
    labelSmall: textStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.blackText.withValues(alpha: 0.7),
    ),
    labelMedium: textStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.blackText,
    ),
    labelLarge: textStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.blackText,
    ),
  ),
);

ThemeData darkTheme = FlexThemeData.dark(
  useMaterial3: true,
  fontFamily: 'Poppins',
  colors: FlexSchemeColor(
    primary: AppColors.primary,
    secondary: AppColors.whiteText,
    appBarColor: AppColors.darkBg,
    tertiary: AppColors.whiteText.withValues(alpha: .1),
  ),
).copyWith(
  scaffoldBackgroundColor: AppColors.darkBg,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBg,
  ),
  textTheme: TextTheme(
    headlineLarge: textStyle.copyWith(fontSize: 24, color: AppColors.whiteText),
    headlineMedium:
        textStyle.copyWith(fontSize: 20, color: AppColors.whiteText),
    headlineSmall: textStyle.copyWith(fontSize: 16, color: AppColors.whiteText),
    labelSmall: textStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.whiteText.withValues(alpha: .7),
    ),
    labelMedium: textStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.whiteText,
    ),
    labelLarge: textStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.whiteText,
    ),
  ),
);
