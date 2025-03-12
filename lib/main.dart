import 'package:alarm_tasker/config/routes/routes.dart';
import 'package:alarm_tasker/features/theme/domain/entities/theme_entity.dart';
import 'package:alarm_tasker/features/theme/presentation/cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import 'config/theme/app_theme.dart';
import 'features/theme/presentation/cubit/theme_cubit.dart';
import 'injection_container.dart';

void main() async {
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ThemeCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: Routes().router,
                theme: getAppTheme(
                    primaryColor: state.primaryColor,
                    isDarkMode: state.isDarkMode,
                    textColor: state.textColor));
          },
        ),
      ),
    );
  }
}
