import 'package:alarm_tasker/features/tasks/domain/entities/sub_task.dart';
import 'package:flutter/material.dart';

Widget subTasksWidget(List<SubTaskEntity> subTasks) {
  return ListView.builder(
    itemCount: subTasks.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(subTasks[index].title),
      );
    },
  );
}
