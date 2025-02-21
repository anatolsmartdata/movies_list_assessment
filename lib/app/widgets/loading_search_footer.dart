import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/app/infrastrucutre/bloc/list-bloc/list_bloc.dart';

class LoadingSearchFooter extends StatelessWidget {
  const LoadingSearchFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesListBloc, MoviesListState>(
      builder: (BuildContext context, MoviesListState state) {
        bool isLoading = state.status == MoviesListStatus.loading;
        return SliverVisibility(
          visible: isLoading,
          sliver: SliverToBoxAdapter(
            child: Align(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: CircularProgressIndicator(),
              ),
            ),
          )
        );
      },
    );
  }
}