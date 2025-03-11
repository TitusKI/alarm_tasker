import 'package:alarm_tasker/features/tasks/presentation/pages/tasks.dart';
import 'package:go_router/go_router.dart';

class Routes {
  final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const Tasks(),
    ),
    GoRoute(path: '/tasks', builder: (context, state) => const Tasks()),
  ]);
}
