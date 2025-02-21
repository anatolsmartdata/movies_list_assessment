sealed class MovieDetailsEvent {}

final class InitMovieDetails extends MovieDetailsEvent {}

final class FetchMovieDetails extends MovieDetailsEvent {
  final String imdbID;
  FetchMovieDetails(this.imdbID);
}