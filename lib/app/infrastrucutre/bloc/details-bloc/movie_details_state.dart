import '../../models/movie_details_dto.dart';

sealed class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsFetched extends MovieDetailsState {
  final MovieDetailsDto movieDetails;
  MovieDetailsFetched(this.movieDetails);
}

class MovieDetailsException extends MovieDetailsState {}