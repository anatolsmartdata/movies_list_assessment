import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/app/infrastrucutre/bloc/list-bloc/list_bloc.dart';
import 'package:movies_explorer/app/infrastrucutre/models/models.dart';
import 'package:movies_explorer/app/widgets/movie_list_item.dart';

import '../widgets/error_search_header.dart';
import '../widgets/header_search_input.dart';
import '../widgets/initial_search_header.dart';
import '../widgets/loading_search_footer.dart';
import '../widgets/success_search_header.dart';

class SearchMovies extends StatefulWidget {
  const SearchMovies({super.key});

  @override
  State<SearchMovies> createState() => SearchMoviesState();
}

class SearchMoviesState extends State<SearchMovies> {
  final scrollController = ScrollController();
  int page = 1;
  String searchStr = '';
  TextEditingController searchController = TextEditingController();

  MoviesListBloc get moviesBloc => context.read<MoviesListBloc>();

  @override
  void initState() {
    scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.clear();
    searchController.dispose();
    super.dispose();
  }

  void onScroll() {
    var st = context.read<MoviesListBloc>().state;
    if (isBottom && st.status != MoviesListStatus.loading) {
      setState(() => page += 1);
      moviesBloc.add(SetListLoading());
      moviesBloc.add(SearchMoviesEvt(searchStr, page, false));
    }
  }

  bool get isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  clearSearch() {
    searchController.clear();
    setState(() {
      searchStr = '';
      page = 1;
    });
    moviesBloc.add(ClearSearchedMovies());
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: HeaderSearchInput(
        controller: searchController,
        hintText: 'Search movies',
        suffixActive: searchStr.length > 2,
        onClearTap: clearSearch,
        onChanged: (String searchString) {
          setState(() {
            searchStr = searchString;
          });
          if (searchStr.length > 2) {
            moviesBloc.add(SearchMoviesEvt(searchStr, page, true));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: RefreshIndicator(
        color: Colors.blueAccent,
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () => null);
        },
        child: BlocBuilder<MoviesListBloc, MoviesListState>(
          builder: (BuildContext context, MoviesListState state) {
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              controller: scrollController,
              slivers: [
                EmptySearchHeader(),
                SuccessSearchHeader(),
                ErrorSearchHeader(),
                SliverList.builder(
                  itemCount: state.moviesList.Search.length,
                  itemBuilder: (BuildContext ctx, int idx) {
                    MovieItemDto movieItem = state.moviesList.Search[idx];
                    return MovieListItem(movieItem: movieItem);
                  },
                ),
                LoadingSearchFooter(),
              ],
            );
          },
        ),
      ),
    );
  }
}