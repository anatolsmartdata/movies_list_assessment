import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/app/infrastrucutre/bloc/list-bloc/list_bloc.dart';

class SuccessListHeader extends StatelessWidget {
  final int totalMovies;
  const SuccessListHeader({super.key, this.totalMovies = 0});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesListBloc, MoviesListState>(
      builder: (BuildContext context, MoviesListState state) {
        bool isNotEmpty =  state.moviesList.Search.isNotEmpty;
        return SliverVisibility(
          visible: isNotEmpty,
          sliver: SliverAppBar(
            leadingWidth: double.maxFinite,
            automaticallyImplyLeading: true,
            title: Text('Movies list: $totalMovies'),
            centerTitle: false,
          ),
        );
      },
    );
  }
}