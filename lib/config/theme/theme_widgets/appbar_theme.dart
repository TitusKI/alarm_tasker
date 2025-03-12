import 'package:flutter/material.dart';

class TAppBarTheme {
  TAppBarTheme._();
  AppBarTheme lightAppBarTheme(Color primaryColor) => AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: primaryColor,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white, size: 24),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white));
  AppBarTheme darkAppBarTheme(Color primaryColor) => AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: primaryColor,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white, size: 24),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white));
}
