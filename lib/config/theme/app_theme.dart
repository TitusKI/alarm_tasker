import 'package:alarm_tasker/config/theme/theme_widgets/appbar_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_widgets/text_theme.dart';

ThemeData getAppTheme(
    {required Color primaryColor,
    required bool isDarkMode,
    required textColor}) {
  return ThemeData(
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    primaryColor: primaryColor,
    appBarTheme: TAppBarTheme.lightAppBarTheme(primaryColor, textColor),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    textTheme:
        GoogleFonts.robotoTextTheme(TTextTheme.lightTextTheme(textColor)),
    // setting drawer header theme of my app

    // settng box decoration theme of my app

    colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: isDarkMode ? Brightness.dark : Brightness.light),
  );
}
