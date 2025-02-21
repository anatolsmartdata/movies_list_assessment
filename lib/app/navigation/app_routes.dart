import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_explorer/app/infrastrucutre/bloc/list-bloc/list_bloc.dart';
import 'package:movies_explorer/app/navigation/path_strings.dart';
import 'package:movies_explorer/app/screens/screens.dart';

abstract class Routes {

  Routes._();

  static tabRoutes(GlobalKey<NavigatorState> parentKey) => [
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: parentKey,
      branches: [
        StatefulShellBranch(
          // navigatorKey: homeTabNavigatorKey,
          routes: [
            GoRoute(
              path: Paths.SEARCH_MOVIES,
              pageBuilder: (context, GoRouterState state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: SearchMovies()
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: searchTabNavigatorKey,
          routes: [
            GoRoute(
              path: Paths.MOVIES_LIST,
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: MoviesList()
                );
              },
            ),
          ],
        ),
      ],
      pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
          ) {
        return MaterialPage(
          key: state.pageKey,
          child: BottomNavBox(navScreen: navigationShell)
        );
      },
    ),
  ];

  static List<RouteBase> routes(GlobalKey<NavigatorState> parentKey) => [
    ...tabRoutes(parentKey),
    GoRoute(
      parentNavigatorKey: parentKey,
      path: Paths.MOVIE_DETAILS,
      pageBuilder: (context, state) {
        String? imdbID = state.pathParameters['movieId'];
        return MaterialPage(
            key: state.pageKey,
            child: MovieDetails(imdbID: imdbID!)
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: parentKey,
      path: Paths.SPLASH,
      pageBuilder: (context, state) {
        return MaterialPage(
            key: state.pageKey,
            child: SplashScreen()
        );
      },
    ),
  ];
}

class BottomNavBox extends StatelessWidget {
  const BottomNavBox({super.key, required this.navScreen});

  final StatefulNavigationShell navScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navScreen,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade300
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
          currentIndex: navScreen.currentIndex,
          onTap: (index) {
            if (index != navScreen.currentIndex) {
              navScreen.goBranch(
                index,
                initialLocation: index == navScreen.currentIndex,
              );
            }
          },
          unselectedFontSize: 10,
          selectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.search, size: 25),
              icon: Icon(Icons.search, size: 22),
              label: 'SEARCH',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.save, size: 25),
              icon: Icon(Icons.save, size: 22),
              label: 'SAVED SEARCHES',
            ),
          ],
        ),
      ),
    );
  }
}