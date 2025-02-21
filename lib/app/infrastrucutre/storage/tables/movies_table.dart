import 'package:sqflite/sqflite.dart';

class MoviesTable {
  static const String MOVIES_TABLE_NAME = 'movies_list';

  static void createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $MOVIES_TABLE_NAME(
        id INTEGER PRIMARY KEY,
        Title TEXT,
        Year TEXT,
        imdbID TEXT,
        Type TEXT,
        Poster TEXT
      )
    ''');
  }
}

var list = {
  "Search": [
    {
      "Title": "Batman: Arkham Origins",
      "Year": "2013",
      "imdbID": "tt2842418",
      "Type": "game",
      "Poster": "https://m.media-amazon.com/images/M/MV5BMzczNTkxODU5NF5BMl5BanBnXkFtZTgwNDcwMzU1MDE@._V1_SX300.jpg"
    },
    {
      "Title": "Batman: Mystery of the Batwoman",
      "Year": "2003",
      "imdbID": "tt0346578",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/images/M/MV5BN2IwYTVlZGQtOTRhNy00MDI5LThmMTUtYWI1MGUwMGFkYzI1XkEyXkFqcGdeQXVyNzQzNzQxNzI@._V1_SX300.jpg"
    },
    {
      "Title": "Batman: The Brave and the Bold",
      "Year": "2008–2011",
      "imdbID": "tt1213218",
      "Type": "series",
      "Poster": "https://m.media-amazon.com/images/M/MV5BM2FkYTQ2MzUtNWI1NC00MTM0LTgyNzYtMDM3NmE1OWYyNjRjXkEyXkFqcGc@._V1_SX300.jpg"
    },
    {
      "Title": "The Batman Superman Movie: World's Finest",
      "Year": "1997",
      "imdbID": "tt0169590",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/images/M/MV5BZmYwMWM1MTEtODA0ZS00OTY3LTgzMTQtOGY5Y2Q2ZmNjNTg1XkEyXkFqcGc@._V1_SX300.jpg"
    },
    {
      "Title": "Batman vs Teenage Mutant Ninja Turtles",
      "Year": "2019",
      "imdbID": "tt9775360",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/images/M/MV5BNzk3MGZlYWQtNDU4Ny00Y2I5LTk2YmItM2QxYjFiMjM0ZmQxXkEyXkFqcGdeQXVyNDUzMTkzMDI@._V1_SX300.jpg"
    },
    {
      "Title": "The Batman vs. Dracula",
      "Year": "2005",
      "imdbID": "tt0472219",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/images/M/MV5BMTkyMTMwNjA3MV5BMl5BanBnXkFtZTcwNzE2NTI2OQ@@._V1_SX300.jpg"
    },
    {
      "Title": "Batman: Arkham Knight",
      "Year": "2015",
      "imdbID": "tt3554580",
      "Type": "game",
      "Poster": "https://m.media-amazon.com/images/M/MV5BMTc0MTcxMzQ0Ml5BMl5BanBnXkFtZTgwNDc3MzE0MTE@._V1_SX300.jpg"
    },
    {
      "Title": "Batman: Soul of the Dragon",
      "Year": "2021",
      "imdbID": "tt12885852",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/images/M/MV5BYzA4NmVhOTItNzg4MC00YTJjLTk5ZmMtYTJmY2NhM2ZiNmMyXkEyXkFqcGc@._V1_SX300.jpg"
    },
    {
      "Title": "Batman Beyond: The Movie",
      "Year": "1999",
      "imdbID": "tt0231237",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/images/M/MV5BMjQ1NmJiNmUtNmNlOC00YTRhLWJlZmUtN2U1ZjgxYjM1N2IzXkEyXkFqcGc@._V1_SX300.jpg"
    },
    {
      "Title": "Batman: Return of the Caped Crusaders",
      "Year": "2016",
      "imdbID": "tt5973626",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/images/M/MV5BMzczMWZmYzQtMjQ4Mi00MWNjLTgyNWYtYjE0ZTEyMmZhMzJiXkEyXkFqcGc@._V1_SX300.jpg"
    }
  ],
  "totalResults": "599",
  "Response": "True"
};