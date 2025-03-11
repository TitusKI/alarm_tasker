import 'dart:ui';

import '../../../../injection_container.dart';
import '../repositories/theme_repository.dart';

class GetThemeUsecase {
  Color? getPrimaryColor() {
    return sl<ThemeRepository>().getPrimaryColor();
  }

  bool? getThemeMode() {
    return sl<ThemeRepository>().getThemeMode();
  }
}
