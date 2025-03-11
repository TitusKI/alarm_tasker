import 'package:alarm_tasker/core/usecase/usecase.dart';

import '../../../../injection_container.dart';
import '../repositories/theme_repository.dart';

class ToggleThemeModeUsecase implements Usecase<void, bool> {
  @override
  Future<void> call({bool? params}) async {
    return await sl<ThemeRepository>().updateThemeMode(params!);
  }
}
