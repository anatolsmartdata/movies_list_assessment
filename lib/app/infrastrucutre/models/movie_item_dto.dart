import 'dart:convert';
import 'package:equatable/equatable.dart';

class MovieItemDto extends Equatable {

  final String imdbID;
  final String Title;
  final String Year;
  final String Type;
  final String Poster;

  const MovieItemDto({
    required this.imdbID,
    required this.Title,
    required this.Year,
    required this.Type,
    required this.Poster,
  });

  factory MovieItemDto.fromJson(String jsonString) =>
      MovieItemDto.fromMap(json.decode(jsonString));

  String toJson() => json.encode(toMap());

  factory MovieItemDto.fromMap(Map<String, dynamic> jsonMap) =>
      MovieItemDto(
          imdbID: jsonMap['imdbID'],
          Title: jsonMap['Title'],
          Year: jsonMap['Year'],
          Type: jsonMap['Type'],
          Poster: jsonMap['Poster']
      );

  Map<String, dynamic> toMap() => {
    'imdbID': imdbID,
    'Title': Title,
    'Year': Year,
    'Type': Type,
    'Poster': Poster,
  };

  MovieItemDto copyWith({
    String? imdbID,
    String? Title,
    String? Year,
    String? Type,
    String? Poster}) => MovieItemDto(
    imdbID: imdbID ?? this.imdbID,
    Title: Title ?? this.Title,
    Year: Year ?? this.Year,
    Type: Type ?? this.Type,
    Poster: Poster ?? this.Poster,
  );

  bool get isNotEmpty => props.isNotEmpty;
  bool get isEmpty => props.isEmpty;

  @override
  List<Object?> get props => [
    imdbID,
    Title,
    Year,
    Type,
    Poster,
  ];
}