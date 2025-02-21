import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/app/infrastrucutre/bloc/list-bloc/list_bloc.dart';
import 'package:movies_explorer/app/widgets/header_search_input.dart';

import '../infrastrucutre/models/movie_item_dto.dart';
import '../infrastrucutre/storage/movies_storage.dart';
import '../widgets/empty_list_header.dart';
import '../widgets/error_list_search_header.dart';
import '../widgets/error_search_header.dart';
import '../widgets/initial_search_header.dart';
import '../widgets/loading_search_footer.dart';
import '../widgets/movie_list_item.dart';
import '../widgets/success_list_header.dart';
import '../widgets/success_search_header.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  final scrollController = ScrollController();
  int page = 1;
  String searchStr = '';
  Timer? debounceTimer;
  int moviesNr = 0;
  int updated = 0;

  MoviesListBloc get moviesBloc => context.read<MoviesListBloc>();

  @override
  void initState() {
    scrollController.addListener(onScroll);
    setTotalMovies();
    moviesBloc.add(FetchSavedMovies(page));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    debounceTimer?.cancel();
    super.dispose();
  }

  setTotalMovies() async {
    int totalMovies = await MoviesStorage().getTotalLength();
    setState(() => moviesNr = totalMovies);
  }

  void onScroll() {
    var st = context.read<MoviesListBloc>().state;
    String moviesNum = st.savedList.totalResults;
    bool isLast = moviesNr < page * 10;
    if (isBottom && st.status != MoviesListStatus.loading && !isLast) {
      moviesBloc.add(SetListLoading());
      setState(() => page += 1);
      if (searchStr.isEmpty) {
        moviesBloc.add(FetchSavedMovies(page));
      }
      else {
        moviesBloc.add(SearchSavedMovies(searchStr, page, false));
      }
    }
  }

  bool get isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: HeaderSearchInput(
        hintText: 'Filter saved movies',
        icon: Icons.filter_alt_outlined,
        onChanged: (String searchString) {
          setState(() {
            searchStr = searchString;
          });
          moviesBloc.add(SearchSavedMovies(searchStr, page, true));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: RefreshIndicator.adaptive(
        color: Colors.blueAccent,
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () => null);
        },
        child: BlocBuilder<MoviesListBloc, MoviesListState>(
          builder: (BuildContext context, MoviesListState state) {
            return CustomScrollView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              slivers: [
                EmptyListHeader(),
                SuccessListHeader(totalMovies: moviesNr,),
                ErrorListHeader(),
                SliverList.builder(
                  itemCount: state.savedList.Search.length,
                  itemBuilder: (BuildContext ctx, int idx) {
                    MovieItemDto movieItem = state.savedList.Search[idx];
                    return MovieListItem(movieItem: movieItem);
                  },
                ),
                LoadingSearchFooter(),
              ],
            );
          }
        ),
      ),
    );
  }
}