import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/app/infrastrucutre/bloc/list-bloc/list_bloc.dart';
import 'package:movies_explorer/app/navigation/app_navigation.dart';

import 'app/infrastrucutre/bloc/details-bloc/details_bloc.dart';

void main() {
  AppNavigation.initRouter;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MoviesListBloc>(create:
              (context) => MoviesListBloc()
          ),
          BlocProvider<MovieDetailsBloc>(create:
              (context) => MovieDetailsBloc(MovieDetailsInitial())
          ),
        ],
        child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppNavigation.router,
        )
    );
  }
}