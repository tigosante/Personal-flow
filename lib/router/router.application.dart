import 'package:auto_route/auto_route.dart';
import 'package:personal_flow/screens/home/home.screen.dart';
import 'package:personal_flow/screens/task/task.screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: HomeScreen, initial: true),
    AutoRoute(page: TaskScreen),
  ],
)
class $RouterApplication {}
