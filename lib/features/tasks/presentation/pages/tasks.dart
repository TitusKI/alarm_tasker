import 'package:alarm_tasker/core/resources/generic_state.dart';
import 'package:alarm_tasker/features/tasks/domain/entities/sub_task.dart';
import 'package:alarm_tasker/features/tasks/domain/entities/sub_task_title.dart';
import 'package:alarm_tasker/features/tasks/presentation/cubit/tasks_w_subtask_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../injection_container.dart';
import 'package:logging/logging.dart';
import '../../../theme/presentation/cubit/theme_cubit.dart';
import '../../data/datasources/db_constant.dart';
import '../../data/models/task_w_subtask.dart';
import '../cubit/subtask_titles_cubit.dart';
import '../cubit/subtasks_cubit.dart';
import '../widgets/build_quick_add_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/sublist_dialog.dart';

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
        appBar: _buildAppBar(),
        drawer: drawer(context),
        body: _buildBody(),
        bottomSheet: tabController != null
            ? QuickAddBar(tabController: tabController!)
            : SizedBox());
  }

  AppBar _buildAppBar() {
    final taskTitle = context.select(
        (TasksWSubtaskCubit cubit) => cubit.state.data?.title ?? 'Tasks');

    return AppBar(
      title: Text(taskTitle.isEmpty ? "Tasks" : taskTitle,
          style: Theme.of(context).textTheme.headlineSmall),
      bottom: _buildTabBar(),
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
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<SubTaskTitleCubit,
                GenericState<List<SubTaskTitleEntity>>>(
              builder: (context, state) {
                return TabBar(
                  tabAlignment: TabAlignment.start,
                  controller: tabController,
                  isScrollable: true,
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  labelColor: Theme.of(context).colorScheme.onPrimary,
                  unselectedLabelColor: Colors.white,
                  tabs: task.subTaskTitles
                      .map((title) => Tab(
                              child: Text(
                            title.title,
                            style: textTheme.bodyLarge,
                          )))
                      .toList(),
                );
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_circle, color: theme.textColor),
            onPressed: () {
              showSubListAddDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    final theme = context.read<ThemeCubit>().state;
    final task = context.watch<TasksWSubtaskCubit>().state.data;

    if (task == null || task.subTaskTitles.isEmpty) {
      return _buildEmptyState();
    }

    return BlocBuilder<TasksWSubtaskCubit, GenericState<TaskWithSubTasks>>(
      builder: (context, state) {
        //  if (state.data == null || state.data!.subTaskTitles.isEmpty) {
        //     return _buildEmptyState();
        //   }

        final TaskWithSubTasks updatedTask = state.data!;

        return PageStorage(
          bucket: _pageStorageBucket,
          child: TabBarView(
            controller: tabController,
            children: updatedTask.subTaskTitles.map((title) {
              return FutureBuilder<Widget>(
                future: _buildSubTaskList(title.subtasks),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return snapshot.data ?? const SizedBox();
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<Widget> _buildSubTaskList(List<SubTask> subtasks) async {
    if (subtasks.isEmpty) {
      return _buildEmptyState();
    }
    return ListView(
      children:
          subtasks.map((subTask) => SubTaskWidget(subTask: subTask)).toList(),
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

class SubTaskWidget extends StatelessWidget {
  final SubTask subTask;

  const SubTaskWidget({super.key, required this.subTask});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subTask.title),
      subtitle: Text(subTask.description ?? ''),
    );
  }
}
