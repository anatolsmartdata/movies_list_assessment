import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:movies_explorer/app/infrastrucutre/models/rating_dto.dart';

class MovieDetailsDto extends Equatable {

  final String imdbID;
  final String Title;
  final String Year;
  final String Rated;
  final String Released;
  final String Runtime;
  final String? Genre;
  final String? Director;
  final String? Writer;
  final String? Actors;
  final String? Plot;
  final String? Language;
  final String? Country;
  final String? Awards;
  final String? Poster;
  final String? Metascore;
  final String? imdbRating;
  final String? imdbVotes;
  final String? Type;
  final String? DVD;
  final String? BoxOffice;
  final String? Production;
  final String? Website;
  final String? Response;
  final List<RatingDto>? Ratings;

  const MovieDetailsDto({
    required this.imdbID,
    required this.Title,
    required this.Year,
    required this.Rated,
    required this.Released,
    required this.Runtime,
    this.Genre,
    this.Director,
    this.Writer,
    this.Actors,
    this.Plot,
    this.Language,
    this.Country,
    this.Awards,
    this.Poster,
    this.Metascore,
    this.imdbRating,
    this.imdbVotes,
    this.Type,
    this.DVD,
    this.BoxOffice,
    this.Production,
    this.Website,
    this.Response,
    this.Ratings,
  });

  factory MovieDetailsDto.fromJson(String jsonString) =>
      MovieDetailsDto.fromMap(json.decode(jsonString));

  String toJson() => json.encode(toMap());

  factory MovieDetailsDto.fromMap(Map<String, dynamic> jsonMap) {
    return MovieDetailsDto(
      imdbID: jsonMap['imdbID'],
      Title: jsonMap['Title'],
      Year: jsonMap['Year'],
      Rated: jsonMap['Rated'],
      Released: jsonMap['Released'],
      Runtime: jsonMap['Runtime'],
      Genre: jsonMap['Genre'],
      Director: jsonMap['Director'],
      Writer: jsonMap['Writer'],
      Actors: jsonMap['Actors'],
      Plot: jsonMap['Plot'],
      Language: jsonMap['Language'],
      Country: jsonMap['Country'],
      Awards: jsonMap['Awards'],
      Poster: jsonMap['Poster'],
      Metascore: jsonMap['Metascore'],
      imdbRating: jsonMap['imdbRating'],
      imdbVotes: jsonMap['imdbVotes'],
      Type: jsonMap['Type'],
      DVD: jsonMap['DVD'],
      BoxOffice: jsonMap['BoxOffice'],
      Production: jsonMap['Production'],
      Website: jsonMap['Website'],
      Response: jsonMap['Response'],
      Ratings: List.of(jsonMap['Ratings']).map(
              (ratingItem) => RatingDto.fromMap(ratingItem)
      ).toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    'imdbID': imdbID,
    'Title': Title,
    'Year': Year,
    'Rated': Rated,
    'Released': Released,
    'Runtime': Runtime,
    'Genre': Genre,
    'Director': Director,
    'Writer': Writer,
    'Actors': Actors,
    'Plot': Plot,
    'Language': Language,
    'Country': Country,
    'Awards': Awards,
    'Poster': Poster,
    'Metascore': Metascore,
    'imdbRating': imdbRating,
    'imdbVotes': imdbVotes,
    'Type': Type,
    'DVD': DVD,
    'BoxOffice': BoxOffice,
    'Production': Production,
    'Website': Website,
    'Response': Response,
    'Ratings': Ratings,
  };

  MovieDetailsDto copyWith({
    String? imdbID,
    String? Title,
    String? Year,
    String? Rated,
    String? Released,
    String? Runtime,
    String? Genre,
    String? Director,
    String? Writer,
    String? Actors,
    String? Plot,
    String? Language,
    String? Country,
    String? Awards,
    String? Poster,
    String? Metascore,
    String? imdbRating,
    String? imdbVotes,
    String? Type,
    String? DVD,
    String? BoxOffice,
    String? Production,
    String? Website,
    String? Response,
    List<RatingDto>? Ratings,
  }) => MovieDetailsDto(
      imdbID: imdbID ?? this.imdbID,
      Title: Title ?? this.Title,
      Year: Year ?? this.Year,
      Rated: Rated ?? this.Rated,
      Released: Released ?? this.Released,
    Runtime: Runtime ?? this.Runtime,
    Genre: Genre ?? this.Genre,
    Director: Genre ?? this.Director,
    Writer: Writer ?? this.Writer,
    Actors: Actors ?? this.Actors,
    Plot: Plot ?? this.Plot,
    Language: Language ?? this.Language,
    Country: Country ?? this.Country,
    Awards: Awards ?? this.Awards,
    Poster: Poster ?? this.Poster,
    Metascore: Metascore ?? this.Metascore,
    imdbRating: imdbRating ?? this.imdbRating,
    imdbVotes: imdbVotes ?? this.imdbVotes,
    Type: Type ?? this.Type,
    DVD: DVD ?? this.DVD,
    BoxOffice: BoxOffice ?? this.BoxOffice,
    Production: Production ?? this.Production,
    Website: Website ?? this.Website,
    Response: Response ?? this.Response,
    Ratings: Ratings ?? this.Ratings,
  );

  bool get isNotEmpty => props.isNotEmpty;
  bool get isEmpty => props.isEmpty;

  @override
  List<Object?> get props => [
    imdbID,
    Title,
    Year,
    Rated,
    Released,
    Runtime,
    Genre,
    Director,
    Writer,
    Actors,
    Plot, // description
    Language,
    Country,
    Awards,
    Poster,
    Metascore,
    imdbRating,
    imdbVotes,
    Type,
    DVD,
    BoxOffice,
    Production,
    Website,
    Response,
    Ratings,
  ];
}