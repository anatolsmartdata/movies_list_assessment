sealed class MoviesListEvent {}

final class FetchMoviesList extends MoviesListEvent {
  final int page;
  FetchMoviesList(this.page);
}

final class SearchMoviesEvt extends MoviesListEvent {
  final String searchString;
  final int page;
  final bool isNewSearch;

  SearchMoviesEvt(this.searchString, this.page, this.isNewSearch);
}

final class FetchSavedMovies extends MoviesListEvent {
  final int page;

  FetchSavedMovies(this.page);
}

final class SearchSavedMovies extends MoviesListEvent {
  final String searchString;
  final int page;
  final bool isNewSearch;

  SearchSavedMovies(this.searchString, this.page, this.isNewSearch);
}

final class SetListLoading extends MoviesListEvent {}