import 'package:equatable/equatable.dart';

import '../../models/models.dart';

enum MoviesListStatus { initial, loading, success, failure }

final class MoviesListState extends Equatable {
  final MoviesListModel moviesList;
  final MoviesListModel savedList;
  final MoviesListStatus status;

  const MoviesListState({
    this.moviesList = const MoviesListModel(Search: [], totalResults: '', Response: ''),
    this.savedList = const MoviesListModel(Search: [], totalResults: '', Response: ''),
    this.status = MoviesListStatus.initial
  });

  MoviesListState copyWith({
    MoviesListStatus? status,
    MoviesListModel? moviesList,
    MoviesListModel? savedList,
  }) {
    return MoviesListState(
      moviesList: moviesList ?? this.moviesList,
      savedList: savedList ?? this.savedList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    moviesList,
    savedList,
    status
  ];
}

// final class InitialListState extends MoviesListState {}
//
// final class LoadingListState extends MoviesListState {}
//
// final class SuccessListState extends MoviesListState {
//   final MoviesListModel moviesList;
//   const SuccessListState({required this.moviesList});
// }
//
// final class ExceptionListState extends MoviesListState {
//   final String errorMessage;
//   const ExceptionListState({required this.errorMessage});
// }