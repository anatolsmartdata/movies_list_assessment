import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../infrastrucutre/bloc/list-bloc/movies_list_bloc.dart';
import '../infrastrucutre/bloc/list-bloc/movies_list_state.dart';

class ErrorSearchHeader extends StatelessWidget {
  const ErrorSearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesListBloc, MoviesListState>(
      builder: (BuildContext context, MoviesListState state) {
        bool isNotEmpty = state.moviesList.isNotEmpty;
        bool isFailure = state.status == MoviesListStatus.failure;
        return SliverVisibility(
          visible: isNotEmpty && isFailure,
          sliver: SliverAppBar(
            leadingWidth: double.maxFinite,
            automaticallyImplyLeading: true,
            title: Text(state.moviesList.Error ?? ''),
            centerTitle: false,
          ),
        );
      },
    );
  }
}