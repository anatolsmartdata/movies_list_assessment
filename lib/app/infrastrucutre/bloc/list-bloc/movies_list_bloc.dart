import 'package:bloc/bloc.dart';
import 'package:movies_explorer/app/infrastrucutre/services/movies-service/movies_service.dart';
import 'package:movies_explorer/app/infrastrucutre/storage/movies_storage.dart';

import '../../models/models.dart';
import 'list_bloc.dart';

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  MoviesListBloc() : super(MoviesListState()) {
    on<SetListLoading>(setLoading);
    on<SearchMoviesEvt>(searchMovies);
    on<ClearSearchedMovies>(clearSearchedMovies);
    on<FetchSavedMovies>(fetchSavedMovies);
    on<SearchSavedMovies>(searchSavedMovies);
  }

  MoviesStorage get storage => MoviesStorage();

  searchMovies(MoviesListEvent event, Emitter<MoviesListState> emit) async {
    if (event is SearchMoviesEvt) {
      String searchString = event.searchString;
      int page = event.page;
      int? total = int.tryParse(state.moviesList.totalResults) ?? 0;
      if (page * 10 < total || state.status == MoviesListStatus.initial) {
        final moviesService = MoviesService();
        dynamic searchResults = await moviesService.searchMovies(searchString, page);
        if (searchResults != null) {
          if (searchResults is Map<String, dynamic>) {
            emit(state.copyWith(
              status: MoviesListStatus.failure,
              moviesList: state.moviesList.copyWith(
                Response: '',
                totalResults: '0',
                Search: [],
                Error: searchResults['Error']
              ),
            ));
          }
          else if (searchResults is MoviesListModel) {
            await storage.insertMoviesList(searchResults.Search);
            var oldList = event.isNewSearch ? [] : [...state.moviesList.Search];
            emit(state.copyWith(
                status: MoviesListStatus.success,
                moviesList: state.moviesList.copyWith(
                    Response: searchResults.Response,
                    totalResults: searchResults.totalResults,
                    Search: event.isNewSearch ? [
                      ...searchResults.Search
                    ] : [
                      ...oldList,
                      ...searchResults.Search
                    ]
                )
            ));
          }
        }
      }
    }
  }

  clearSearchedMovies(MoviesListEvent event, Emitter<MoviesListState> emit) {
    emit(
      state.copyWith(
        status: MoviesListStatus.initial,
        moviesList: state.moviesList.copyWith(
          Response: '',
          totalResults: '',
          Search: []
        )
      )
    );
  }

  setLoading(MoviesListEvent event, Emitter<MoviesListState> emit) async {
    emit(state.copyWith(
      status: MoviesListStatus.loading
    ));
  }

  fetchSavedMovies(MoviesListEvent event, Emitter<MoviesListState> emit) async {
    if (event is FetchSavedMovies) {
      MoviesListModel? movies = await storage.getSavedMoviesList(event.page);
      List moviesList = movies != null ? movies.Search : [];
      emit(
          state.copyWith(
              status: MoviesListStatus.success,
              savedList: state.savedList.copyWith(
                  Response: '',
                  totalResults: '',
                  Search: [
                    ...state.savedList.Search,
                    ...moviesList
                  ]
              )
          )
      );
    }
  }

  searchSavedMovies(MoviesListEvent event, Emitter<MoviesListState> emit) async {
    if (event is SearchSavedMovies) {
      try {
        MoviesListModel? movies = await storage.filterSavedMoviesList(event.searchString, event.page);
        List moviesList = movies != null && movies.isNotEmpty ?
        movies.Search : List.from([]);
        List existingList = event.isNewSearch ? [] : state.savedList.Search;
        bool allEmpty = existingList.isEmpty && moviesList.isEmpty;
        bool noFound = allEmpty && event.searchString.isNotEmpty;
        MoviesListStatus status = noFound ?
        MoviesListStatus.failure : MoviesListStatus.success;
        emit(
            state.copyWith(
                status: status,
                savedList: state.savedList.copyWith(
                    Response: '',
                    totalResults: movies?.totalResults,
                    Search: [
                      ...existingList,
                      ...moviesList
                    ]
                )
            )
        );
      }
      catch(_) {
        emit(
          state.copyWith(
            status: MoviesListStatus.failure
          )
        );
      }
    }
  }
}