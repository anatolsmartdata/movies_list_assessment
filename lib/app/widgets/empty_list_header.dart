import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../infrastrucutre/bloc/list-bloc/movies_list_bloc.dart';
import '../infrastrucutre/bloc/list-bloc/movies_list_state.dart';

class EmptyListHeader extends StatelessWidget {
  const EmptyListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesListBloc, MoviesListState>(
      builder: (BuildContext context, MoviesListState state) {
        bool isEmpty = state.savedList.Search.isEmpty;
        bool isFailure = state.status == MoviesListStatus.failure;
        return SliverVisibility(
          visible: isEmpty && !isFailure,
          sliver: SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text('Empty movies search history'),
              ),
            ),
          ),
        );
      },
    );
  }
}