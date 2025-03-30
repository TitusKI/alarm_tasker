import 'package:alarm_tasker/features/tasks/domain/entities/sub_task_title.dart';
import 'package:alarm_tasker/features/tasks/domain/entities/task.dart';
import 'package:alarm_tasker/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../cubit/subtask_titles_cubit.dart';
import '../cubit/tasks_cubit.dart';
import '../pages/tasks.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({super.key});

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color selectedColor;
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final themeState = context.read<ThemeCubit>().state;
    selectedColor = themeState.primaryColor;
  }

  void changeColor(Color color) {
    setState(() => selectedColor = color);
  }

  Future<void> _saveTask() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task name cannot be empty')),
        );
      }
      return;
    }

    final taskId = UniqueKey().toString();
    final subTaskId = UniqueKey().toString();
    final subTaskTitleCubit = context.read<SubTaskTitleCubit>();

    try {
      if (!mounted) return;

      // Add Task
      await context.read<TaskCubit>().addTask(
            TaskEntity(id: taskId, title: title),
          );
      print("Task added successfully");

      // Add SubTaskTitle
      await subTaskTitleCubit.addSubTaskTitle(
        SubTaskTitleEntity(id: subTaskId, title: title, taskId: taskId),
      );
      print("SubTaskTitle added successfully");

      // Ensure the widget is still mounted before navigation
      if (mounted) {
        context.read<ThemeCubit>().updatePrimaryColor(selectedColor);

        print("Before navigation, taskId: $taskId");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Tasks(taskId: taskId);
          }),
        );
      } else {
        print("Widget is no longer mounted, skipping navigation");
      }
    } catch (e) {
      print("Error saving task: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save task')),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(selectedColor);
    final textColor =
        brightness == Brightness.light ? Colors.black : Colors.white;

    return AlertDialog(
      clipBehavior: Clip.none,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: selectedColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('List Name',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: textColor,
                          )),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "Let's give it a name...",
                      hintStyle: TextStyle(color: textColor.withOpacity(0.7)),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                      ),
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: textColor),
                  ),
                ],
              ),
            ),
            ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: changeColor,
              pickerAreaHeightPercent: 0.8,
              enableAlpha: false,
              displayThumbColor: true,
              paletteType: PaletteType.hueWheel,
              labelTypes: const [],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL',
                        style: TextStyle(color: Colors.orangeAccent)),
                  ),
                  TextButton(
                    onPressed: _saveTask,
                    child: const Text('SAVE',
                        style: TextStyle(color: Colors.orangeAccent)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showColorPicker(BuildContext context) async {
  await showDialog<Color>(
    context: context,
    builder: (context) => const ColorPickerDialog(),
  );
}
