import 'package:flutter/material.dart';

class TAppBarTheme {
  TAppBarTheme._();
  static AppBarTheme lightAppBarTheme(Color primaryColor, Color iconColor) =>
      AppBarTheme(
          elevation: 0,
          centerTitle: false,
          scrolledUnderElevation: 0,
          backgroundColor: primaryColor,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(color: iconColor, size: 24),
          actionsIconTheme: IconThemeData(color: iconColor, size: 24),
          titleTextStyle: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w600, color: iconColor));
  static AppBarTheme darkAppBarTheme(Color primaryColor, Color iconColor) =>
      AppBarTheme(
          elevation: 0,
          centerTitle: false,
          scrolledUnderElevation: 0,
          backgroundColor: primaryColor,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(color: iconColor, size: 24),
          actionsIconTheme: IconThemeData(color: iconColor, size: 24),
          titleTextStyle: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w600, color: iconColor));
}
