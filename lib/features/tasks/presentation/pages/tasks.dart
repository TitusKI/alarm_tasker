import 'dart:async';

import 'package:alarm_tasker/core/resources/generic_state.dart';
import 'package:alarm_tasker/features/tasks/domain/entities/sub_task.dart';
import 'package:alarm_tasker/features/tasks/presentation/cubit/tasks_w_subtask_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../injection_container.dart';
import 'package:logging/logging.dart';
import '../../../theme/presentation/cubit/theme_cubit.dart';
import '../../data/datasources/db_constant.dart';
import '../../data/mapper/subtask_mapper.dart';
import '../../data/models/task_w_subtask.dart';
import '../cubit/subtasks_cubit.dart';
import '../widgets/build_quick_add_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/sublist_dialog.dart';
import '../widgets/subtask_widget.dart';
import 'add_task.dart';

class Tasks extends StatefulWidget {
  final String? taskId;
  const Tasks({super.key, this.taskId});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> with TickerProviderStateMixin {
  TabController? tabController;
  final constData = sl<ConstantLocalDataSource>();
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();

  // Cache the tab widgets to maintain their state
  final Map<String, Widget> _cachedTabWidgets = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  void _initTabController(List<SubTaskTitleWithSubtasks> subTaskTitles) {
    if (tabController == null ||
        tabController!.length != subTaskTitles.length) {
      tabController?.dispose();
      tabController = TabController(length: subTaskTitles.length, vsync: this);
      setState(() {});
    }
  }

  final Logger _logger = Logger('Tasks');

  Future<void> loadData() async {
    Logger.root.level = Level.ALL; // Set the logging level
    Logger.root.onRecord.listen((record) {
      print(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    });

    _logger.info('Logger initialized for Tasks widget');
    _logger.info('Received taskId: ${widget.taskId}');

    if (widget.taskId != null && widget.taskId!.isNotEmpty) {
      await constData.cacheTaskId(widget.taskId!);
    }

    final taskId = constData.getTaskId();
    _logger.info('Cached taskId: $taskId');

    if (!mounted) return;

    if (taskId == null || taskId.isEmpty) {
      await context.read<TasksWSubtaskCubit>().loadTasksWithSubTasks();
    } else {
      _logger.info('Loading tasks with subtasks for taskId: $taskId');
      await context
          .read<TasksWSubtaskCubit>()
          .loadTasksWithSubTasks(id: taskId);
    }

    if (!mounted) return;

    final task = context.read<TasksWSubtaskCubit>().state.data;
    for (var subTask in task?.subTaskTitles ?? []) {
      _logger.info('SubTask: ${subTask.title}');
      for (var sub in subTask.subtasks) {
        _logger.info('SubTask: ${sub.title}');
      }
    }
    if (task != null && task.subTaskTitles.isNotEmpty) {
      _logger.info(
          'Initializing TabController with ${task.subTaskTitles.length} tabs');
      _initTabController(task.subTaskTitles);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      body: Column(
        children: [
          Expanded(child: _buildBody()),
          if (tabController != null) QuickAddBar(tabController: tabController!)
        ],
      ),
      // floatingActionButton: tabController != null
      //     ? Padding(
      //         padding:
      //             EdgeInsets.only(bottom: 50.h), // Move the button upward
      //         child: FloatingActionButton(
      //           elevation: 10.h,
      //           backgroundColor: Colors.amber,
      //           shape: const CircleBorder(),
      //           onPressed: () {
      //             Navigator.of(context).push(MaterialPageRoute(
      //                 builder: (context) => AddTaskScreen()));
      //           },
      //           child: const Icon(
      //             Icons.add,
      //             color: Colors.white,
      //           ),
      //         ),
      //       )
      // : null
    );
  }

  AppBar _buildAppBar() {
    final taskTitle = context.select(
        (TasksWSubtaskCubit cubit) => cubit.state.data?.title ?? 'Tasks');

    return AppBar(
      title: Text(taskTitle.isEmpty ? "Tasks" : taskTitle,
          style: Theme.of(context).textTheme.headlineSmall),
      // bottom: _buildTabBar(),
    );
  }

  PreferredSizeWidget? _buildTabBar() {
    final theme = context.read<ThemeCubit>().state;
    final textTheme = Theme.of(context).textTheme;

    final task = context.watch<TasksWSubtaskCubit>().state.data;

    if (task == null || task.subTaskTitles.isEmpty) return null;
    if (tabController == null ||
        tabController!.length != task.subTaskTitles.length) {
      _initTabController(task.subTaskTitles);
    }

    return PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Row(
          children: [
            Expanded(child:
                BlocBuilder<TasksWSubtaskCubit, GenericState<TaskWithSubTasks>>(
              builder: (context, state) {
                return TabBar(
                  tabAlignment: TabAlignment.start,
                  controller: tabController,
                  isScrollable: true,
                  indicatorColor: Colors.amber,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Theme.of(context).colorScheme.onPrimary,
                  unselectedLabelColor: Colors.white60,
                  tabs: task.subTaskTitles
                      .map((title) => Tab(
                              child: StreamBuilder<SubTaskEntity>(
                            stream: context
                                .read<SubTaskCubit>()
                                .streamcontroler
                                .expand((list) => list),
                            builder: (context, snapshot) {
                              final updatedTask = state.data ?? task;
                              final updatedTitle = updatedTask.subTaskTitles
                                  .firstWhere((t) => t.id == title.id,
                                      orElse: () => title);
                              return Text(
                                "${updatedTitle.title.toUpperCase()}(${updatedTitle.subtasks.where((sub) => sub.isCompleted).length}/${updatedTitle.subtasks.length})",
                                style: textTheme.bodyLarge,
                              );
                            },
                          )))
                      .toList(),
                );
              },
            )),
            IconButton(
              icon: Icon(Icons.add_circle, color: theme.textColor),
              onPressed: () {
                showSubListAddDialog(context);
              },
            ),
          ],
        ));
  }

  Widget _buildBody() {
    final theme = context.read<ThemeCubit>().state;
    final task = context.watch<TasksWSubtaskCubit>().state.data;

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        final taskTitle = context.select(
            (TasksWSubtaskCubit cubit) => cubit.state.data?.title ?? 'Tasks');

        return [
          // drawer(context),
          SliverAppBar(
            title: Text(
              taskTitle.isEmpty ? "Tasks" : taskTitle,
            ),
            floating: true,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                color: Theme.of(context).primaryColor,
              ),
            ),
            expandedHeight:
                kToolbarHeight + (tabController != null ? kToolbarHeight : 0),
            bottom: _buildTabBar(),
          )
        ];
      },
      body: BlocBuilder<TasksWSubtaskCubit, GenericState<TaskWithSubTasks>>(
        builder: (context, state) {
          if (task == null || task.subTaskTitles.isEmpty) {
            return _buildEmptyState();
          }

          final TaskWithSubTasks updatedTask = state.data ?? task;

          // TaskWithSubTasks.empty();

          return PageStorage(
            bucket: _pageStorageBucket,
            child: Stack(
              children: [
                TabBarView(
                  controller: tabController,
                  children: updatedTask.subTaskTitles.map((title) {
                    return FutureBuilder<Widget>(
                      future: _buildSubTaskList(title.subtasks
                          .map((e) => SubTaskMapper.toEntity(e))
                          .toList()),
                      builder: (context, snapshot) {
                        {
                          return snapshot.data ?? const SizedBox();
                        }
                      },
                    );
                  }).toList(),
                ),
                tabController != null
                    ? Positioned(
                      right: 10.r,
                      bottom: 10.h,
                        child: FloatingActionButton(
                          elevation: 10.h,
                          backgroundColor: Colors.amber,
                          shape: const CircleBorder(),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddTaskScreen(
                                    subTaskTitleId: updatedTask
                                        .subTaskTitles[tabController!.index]
                                        .id)));
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<Widget> _buildSubTaskList(List<SubTaskEntity> subtasks) async {
    // if (subtasks.isEmpty) {
    //   return _buildEmptyState();
    // }

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: subtasks.length,
      separatorBuilder: (context, index) => Divider(
        height: 0.5.h,
        color: const Color.fromARGB(187, 185, 184, 184),
      ),
      itemBuilder: (context, index) {
        final SubTaskEntity subTask = subtasks[index];
        return SubTaskWidget(
          subTask: subTask,
          // Removed undefined parameter 'subTaskStream'
          subTaskStreamController: StreamController<SubTaskEntity>.broadcast()
            ..addStream(context
                .read<SubTaskCubit>()
                .streamcontroler
                .asyncExpand((list) => Stream.fromIterable(list))),
          onDelete: (SubTaskEntity? task) {
            // if (task != null) {
            //   context.read<SubTaskCubit>().deleteSubTask(task.id);
            //   AsyncSnapshot.waiting();
            //   context
            //       .read<TasksWSubtaskCubit>()
            //       .loadTasksWithSubTasks(id: constData.getTaskId());
            // }
            if (context.mounted) {
              context.read<SubTaskCubit>().deleteSubTask(task!.id).then((_) => {
                    context
                        .read<TasksWSubtaskCubit>()
                        .loadTasksWithSubTasks(id: constData.getTaskId())
                        .asStream(),
                  });
            }
          },
          onComplete: (task) {
            print("Completed At: ${task.completedAt}");
            if (context.mounted) {
              context
                  .read<SubTaskCubit>()
                  .updateSubTask(SubTaskEntity(
                    id: task.id,
                    subTaskTitleId: task.subTaskTitleId,
                    isCompleted: task.isCompleted,
                    completedAt: task.completedAt,
                  ))
                  .then((_) => {
                        context
                            .read<TasksWSubtaskCubit>()
                            .loadTasksWithSubTasks(id: constData.getTaskId())
                            .asStream(),
                      });
            }
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.list_alt, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text("A fresh list, let's get started.",
              style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}
