import 'package:alarm_tasker/config/theme/theme_widgets/appbar_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_widgets/text_theme.dart';

ThemeData getAppTheme({
  required Color primaryColor,
  required bool isDarkMode,
  required Color textColor,
}) {
  return ThemeData(
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    primaryColor: primaryColor,
    appBarTheme: TAppBarTheme.lightAppBarTheme(primaryColor, textColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    textTheme:
        GoogleFonts.robotoTextTheme(TTextTheme.lightTextTheme(textColor)),
    // Date Picker Theme
    datePickerTheme: DatePickerThemeData(
      shape: LinearBorder(),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      headerBackgroundColor: primaryColor,
      headerForegroundColor: Colors.white,
      todayBackgroundColor: WidgetStateProperty.all(primaryColor.withAlpha(20)),
      todayForegroundColor: WidgetStateProperty.all(primaryColor),
      yearBackgroundColor:
          WidgetStateProperty.all(primaryColor.withOpacity(0.1)),
      yearForegroundColor: WidgetStateProperty.all(primaryColor),
    ),
// Time Picker Theme
    timePickerTheme: TimePickerThemeData(
      helpTextStyle: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      shape: LinearBorder(),
      // backgroundColor: isDarkMode ? Colors.black : Colors.white,
      hourMinuteColor: Colors.transparent,
      hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? (isDarkMode ? Colors.white : Colors.black)
            : (isDarkMode
                ? Colors.white.withAlpha(50)
                : Colors.black.withAlpha(50));
      }),
      dialHandColor: primaryColor,
      dialTextColor: isDarkMode ? Colors.white : Colors.black,
      entryModeIconColor: primaryColor,
      dayPeriodBorderSide: BorderSide.none,
      dayPeriodColor: Colors.transparent,
      dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? (isDarkMode ? Colors.white : Colors.black)
            : (isDarkMode
                ? Colors.white.withAlpha(50)
                : Colors.black.withAlpha(50));
      }),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    ),
  );
}
