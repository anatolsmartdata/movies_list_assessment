import 'package:bloc/bloc.dart';
import 'package:movies_explorer/app/infrastrucutre/bloc/details-bloc/details_bloc.dart';
import 'package:movies_explorer/app/infrastrucutre/models/models.dart';
import 'package:movies_explorer/app/infrastrucutre/services/movies-service/movies_service.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc(super.initialState){
    on<InitMovieDetails>(getInitialDetails);
    on<FetchMovieDetails>(getMovieDetails);
  }

  // MovieDetailsBloc(super.initialState);

  // late final MovieDetailsState initialState;

  getInitialDetails(MovieDetailsEvent event, Emitter<MovieDetailsState> emit) {
    try {
      emit(MovieDetailsInitial());
    } catch(error) {
      emit(MovieDetailsException());
    }
  }
  
  getMovieDetails(MovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    if (event is FetchMovieDetails) {
      final moviesService = MoviesService();
      MovieDetailsDto? searchResults = await moviesService.getMovieDetails(event.imdbID);
      if (searchResults != null) {
        emit(MovieDetailsFetched(searchResults));
      }
      else {
        emit(MovieDetailsException());
      }
    }
  }
}