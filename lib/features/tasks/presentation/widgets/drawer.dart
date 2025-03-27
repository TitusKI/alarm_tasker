import 'package:alarm_tasker/features/tasks/presentation/widgets/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../../theme/presentation/cubit/theme_cubit.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    shape: BeveledRectangleBorder(),
    clipBehavior: Clip.hardEdge,
    width: 280.w,
    child: Builder(
      builder: (context) {
        final primaryColor = sl<ThemeCubit>().state.primaryColor;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: primaryColor,
            statusBarIconBrightness: Brightness.light,
          ),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 50.h,
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child: Text(
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.rtl,
                    'Tasks',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer
                  // context.go('/'); // Move to task screen using go router
                  showColorPicker(context);
                },
                leading: Icon(
                  Icons.add_circle,
                ),
                horizontalTitleGap: 35.w,
                title: Text('New List'),
              ),
              Divider(
                thickness: 0.5.h,
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                horizontalTitleGap: 35.w,
                title: Text('Donate'),
              ),
              ListTile(
                leading: Icon(
                  Icons.help,
                ),
                horizontalTitleGap: 35.w,
                title: Text('Help'),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                ),
                horizontalTitleGap: 35.w,
                title: Text('Settings'),
              ),
            ],
          ),
        );
      },
    ),
  );
}
