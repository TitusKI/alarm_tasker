import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../../theme/data/datasources/theme_local_data_source.dart';
import '../../data/datasources/db_constant.dart';
import '../../domain/entities/sub_task.dart';
import '../cubit/subtasks_cubit.dart';
import '../cubit/tasks_w_subtask_cubit.dart';

class AddTaskScreen extends StatefulWidget {
  final String subTaskTitleId;
  const AddTaskScreen({super.key, required this.subTaskTitleId});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _subTaskController = TextEditingController();
  String taskName = "";
  bool isScrolled = false;
  final constData = sl<ConstantLocalDataSource>();
  final theme = sl<ThemeLocalDataSource>();
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && !isScrolled) {
        setState(() => isScrolled = true);
      } else if (_scrollController.offset <= 50 && isScrolled) {
        setState(() => isScrolled = false);
      }
    });
  }

  Future<void> _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: Stack(
      children: [
        NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              expandedHeight: 160,
              title: isScrolled
                  ? Text(taskName.isEmpty ? "Tasks" : taskName)
                  : null,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.only(left: 45, right: 16, top: 50),
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus && taskName.isEmpty) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    child: TextField(
                      controller: _subTaskController,
                      autofocus:
                          true, // Automatically focuses on this TextField
                      onChanged: (val) => setState(() => taskName = val),
                      decoration: InputDecoration(
                        fillColor: Colors.amber,
                        labelText: "Task Name",
                        labelStyle: textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.normal),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.amber), // Default border color
                        ),
                      ),
                      cursorColor: Colors.amber,
                      style: textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ),
          ],
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  spacing: 0.4.h,
                  children: [
                    buildEditableTile("Notes", "Tap to add notes"),
                    buildDivider(),
                    buildAttachmentTile("Attachment"),
                    buildDivider(),
                    buildSubTaskTile("Sub Tasks"),
                    buildDivider(),
                    buildSelectableTile("List", "Hello"),
                    buildDivider(),
                    buildSelectableTile("Tags", "No tags selected"),
                    buildDivider(),
                    buildDateTile("Due Date", "No reminder set"),
                    buildDivider(),
                    buildToggleTile("Reminder", "Remind me when due"),
                    buildDivider(),
                    buildPriorityTile("Priority", "None"),
                    buildDivider(),
                    buildToggleTile("Highlight", "Make this task stand out"),
                    buildDivider(),
                    buildToggleTile("Completed", ""),
                    buildDivider(),
                    buildInfoTile("Created", "Today 3:43 PM"),
                    buildDivider(),
                  ],
                ),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          bottom: isScrolled ? 16.h : 510.h,
          right: 16.w,
          child: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: Colors.amber,
            onPressed: () {
              final subTaskId = UniqueKey().toString();
              context
                  .read<SubTaskCubit>()
                  .addSubTask(SubTaskEntity(
                    subTaskTitleId: widget.subTaskTitleId,
                    id: subTaskId,
                    title: _subTaskController.text,
                    description: _noteController.text,
                    dueDate: _selectedDateTime,
                  ))
                  .then((_) => {
                        context
                            .read<TasksWSubtaskCubit>()
                            .loadTasksWithSubTasks(id: constData.getTaskId())
                            .asStream(),
                      });
              context.pop();
            },
            child: Icon(Icons.check, color: Colors.white),
          ),
        )
      ],
    ));
  }

  Divider buildDivider() {
    return Divider(
      indent: 15.0.w,
      thickness: 0.5.h,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
    );
  }

  Widget buildEditableTile(String title, String hint) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: TextField(
        controller: _noteController,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Icon(Icons.edit),
    );
  }

  Widget buildSelectableTile(String title, String value) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      trailing: Icon(Icons.arrow_drop_down),
      onTap: () {}, // Implement dropdown selection
    );
  }

  Widget buildAttachmentTile(String title) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Icon(Icons.attach_file),
      onTap: () {},
    );
  }

  Widget buildSubTaskTile(String title) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Icon(Icons.playlist_add),
      onTap: () {},
    );
  }

  Widget buildDateTile(String title, String value) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _selectedDateTime != null
          ? Text("${_selectedDateTime!.toLocal()}".split(".")[0])
          : Text(value),
      trailing: Icon(Icons.calendar_today),
      onTap: _pickDateTime,
    );
  }

  Widget buildToggleTile(String title, String subtitle) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Switch(value: false, onChanged: (val) {}),
    );
  }

  Widget buildPriorityTile(String title, String value) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Row(
        children: [
          Icon(Icons.flag, color: Colors.orange),
          SizedBox(width: 8),
          Text(value),
        ],
      ),
      onTap: () {},
    );
  }

  Widget buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
    );
  }
}
