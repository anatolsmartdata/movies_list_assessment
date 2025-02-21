import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_explorer/app/navigation/app_routes.dart';
import 'package:movies_explorer/app/navigation/path_strings.dart';

class AppNavigation {
  static final AppNavigation routerInstance = AppNavigation.createRouter();

  static AppNavigation get initRouter => routerInstance;

  factory AppNavigation() {
    return initRouter;
  }

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> globalNavKey = GlobalKey<NavigatorState>();

  AppNavigation.createRouter() {
    router = GoRouter(
      navigatorKey: globalNavKey,
      initialLocation: Paths.SEARCH_MOVIES,
      routes: Routes.routes(globalNavKey),
    );
  }
}