import 'package:alarm_tasker/features/tasks/presentation/widgets/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        SizedBox(
          height: 50.h,
          child: DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Tasks',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        ListTile(
          onTap: () => showColorPicker(context),
          leading: Icon(
            Icons.add_circle,
          ),
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
}
