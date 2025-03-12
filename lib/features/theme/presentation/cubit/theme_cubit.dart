import 'package:alarm_tasker/features/tasks/domain/usecases/toggle_theme_mode.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import '../../../tasks/domain/usecases/get_theme.dart';
import '../../../tasks/domain/usecases/update_theme.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
          ThemeState(
              primaryColor:
                  sl<GetThemeUsecase>().getPrimaryColor() ?? Colors.blue,
              isDarkMode: sl<GetThemeUsecase>().getThemeMode() ?? false,
              textColor: sl<GetThemeUsecase>().getTextColor() ?? Colors.white),
        );

  Future<void> updatePrimaryColor(Color newColor) async {
    final brightness = ThemeData.estimateBrightnessForColor(newColor);
    final textColor =
        brightness == Brightness.light ? Colors.black : Colors.white;

    await sl<UpdateThemeUsecase>().call(
        params: ColorParams(
      primaryColor: newColor,
      textColor: textColor,
    ));
    emit(state.copyWith(primaryColor: newColor, textColor: textColor));
  }

  Future<void> toggleDarkMode() async {
    final newMode = !state.isDarkMode;
    sl.call<ToggleThemeModeUsecase>().call(params: newMode);
    emit(state.copyWith(isDarkMode: newMode));
  }
}
