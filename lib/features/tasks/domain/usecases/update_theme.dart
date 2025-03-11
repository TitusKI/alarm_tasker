import 'package:alarm_tasker/core/usecase/usecase.dart';
import 'package:alarm_tasker/features/tasks/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

import '../../../../injection_container.dart';

class UpdateThemeUsecase implements Usecase<void, Color> {
  @override
  Future<void> call({Color? params}) async {
    return await sl<ThemeRepository>().updatePrimaryColor(params!);
  }
}
