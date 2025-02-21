import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/app/infrastrucutre/bloc/list-bloc/list_bloc.dart';

class SuccessSearchHeader extends StatelessWidget {
  const SuccessSearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesListBloc, MoviesListState>(
      builder: (BuildContext context, MoviesListState state) {
        bool isNotEmpty =  state.moviesList.isNotEmpty;
        bool isSuccess = state.status == MoviesListStatus.success;
        String total = state.moviesList.totalResults;
        return SliverVisibility(
          visible: isNotEmpty && isSuccess,
          sliver: SliverAppBar(
            leadingWidth: double.maxFinite,
            automaticallyImplyLeading: true,
            title: Text('Search results: ($total)'),
            centerTitle: false,
          ),
        );
      },
    );
  }
}