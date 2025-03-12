import 'dart:ui';

import '../../../../injection_container.dart';
import '../repositories/theme_repository.dart';

class GetThemeUsecase {
  Color? getPrimaryColor() {
    return sl<ThemeRepository>().getPrimaryColor();
  }

  Color? getTextColor() {
    return sl<ThemeRepository>().getTextColor();
  }

  bool? getThemeMode() {
    return sl<ThemeRepository>().getThemeMode();
  }
}
