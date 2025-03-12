import 'package:alarm_tasker/core/usecase/usecase.dart';
import 'package:alarm_tasker/features/tasks/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

import '../../../../injection_container.dart';

class UpdateThemeUsecase implements Usecase<void, ColorParams> {
  @override
  Future<void> call({ColorParams? params}) async {
    return await sl<ThemeRepository>()
        .updatePrimaryColor(params!.primaryColor, params.textColor);
  }
}

// parameter containing two color
class ColorParams {
  final Color primaryColor;
  final Color textColor;

  ColorParams({required this.primaryColor, required this.textColor});
}
