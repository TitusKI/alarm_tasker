import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();
  static TextTheme lightTextTheme(Color textColor) => TextTheme(
        headlineLarge: TextStyle().copyWith(
            fontSize: 32.0, fontWeight: FontWeight.bold, color: textColor),
        headlineMedium: TextStyle().copyWith(
            fontSize: 24.0, fontWeight: FontWeight.w600, color: textColor),
        headlineSmall: TextStyle().copyWith(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: textColor),
        titleLarge: TextStyle().copyWith(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: textColor),
        titleMedium: TextStyle().copyWith(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: textColor),
        titleSmall: TextStyle().copyWith(
            fontSize: 16.0, fontWeight: FontWeight.w400, color: textColor),
        bodyLarge: TextStyle().copyWith(
            fontSize: 14.0, fontWeight: FontWeight.w500, color: textColor),
        bodyMedium: TextStyle().copyWith(
            fontSize: 14.0, fontWeight: FontWeight.normal, color: textColor),
        bodySmall: TextStyle().copyWith(
            fontSize: 12.0, fontWeight: FontWeight.w500, color: textColor),
        labelLarge: TextStyle().copyWith(
            fontSize: 12.0, fontWeight: FontWeight.normal, color: textColor),
        labelMedium: TextStyle().copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: textColor.withOpacity(0.5)),
      );

  static TextTheme darkTextTheme(Color textColor) => TextTheme(
        headlineLarge: TextStyle().copyWith(
            fontSize: 32.0, fontWeight: FontWeight.bold, color: textColor),
        headlineMedium: TextStyle().copyWith(
            fontSize: 24.0, fontWeight: FontWeight.w600, color: textColor),
        headlineSmall: TextStyle().copyWith(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: textColor),
        titleLarge: TextStyle().copyWith(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: textColor),
        titleMedium: TextStyle().copyWith(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: textColor),
        titleSmall: TextStyle().copyWith(
            fontSize: 16.0, fontWeight: FontWeight.w400, color: textColor),
        bodyLarge: TextStyle().copyWith(
            fontSize: 14.0, fontWeight: FontWeight.w500, color: textColor),
        bodyMedium: TextStyle().copyWith(
            fontSize: 14.0, fontWeight: FontWeight.normal, color: textColor),
        bodySmall: TextStyle().copyWith(
            fontSize: 12.0, fontWeight: FontWeight.w500, color: textColor),
        labelLarge: TextStyle().copyWith(
            fontSize: 12.0, fontWeight: FontWeight.normal, color: textColor),
        labelMedium: TextStyle().copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: textColor.withOpacity(0.5)),
      );
}
