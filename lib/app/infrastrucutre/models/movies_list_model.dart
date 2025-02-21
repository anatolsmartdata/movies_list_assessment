import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'models.dart';

class MoviesListModel extends Equatable {

  final List<MovieItemDto> Search;
  final String totalResults;
  final String Response;
  final String? Error;

  const MoviesListModel({
    required this.Search,
    required this.totalResults,
    required this.Response,
    this.Error,
  });

  Map<String, dynamic> toMap() => {
    'Search': Search.map((movieItem) => movieItem.toMap()),
    'totalResults': totalResults,
    'Response': Response,
    'Error': Error,
  };

  factory MoviesListModel.fromMap(Map<String, dynamic> jsonMap) =>
      MoviesListModel(
        Search: List.from(jsonMap['Search']).map(
              (movieItem) =>
                  MovieItemDto.fromMap(movieItem)).toList(),
        totalResults: jsonMap['totalResults'],
        Response: jsonMap['Response'],
        Error: jsonMap['Error'],
      );

  String toJson() => json.encode(toMap());

  factory MoviesListModel.fromJson(String jsonString) =>
      MoviesListModel.fromMap(json.decode(jsonString));


  MoviesListModel copyWith({
    List<MovieItemDto>? Search,
    String? Response,
    String? Error,
    String? totalResults}) =>
      MoviesListModel(
          Search: Search ?? this.Search,
          Response: Response ?? this.Response,
          Error: Error ?? this.Error,
          totalResults: totalResults ?? this.totalResults);

  bool get isNotEmpty => props.isNotEmpty;
  bool get isEmpty => props.isEmpty;

  @override
  List<Object?> get props => [
    Search,
    totalResults,
    Response,
    Error,
  ];
}