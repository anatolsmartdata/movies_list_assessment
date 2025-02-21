import 'dart:io';

import 'package:movies_explorer/app/infrastrucutre/models/models.dart';
import 'package:movies_explorer/app/infrastrucutre/storage/tables/movies_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MoviesStorage {
  static const String DB_NAME = 'Movies_list.db';
  static const int DB_VERSION = 1;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createStorage();
    return _database!;
  }

  Future<Database> createStorage() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = join(docsDir.path, DB_NAME);
    Database storage = await openDatabase(
      path,
      version: DB_VERSION,
      onCreate: onCreate,
      onUpgrade: updateStorage
    );
    return storage;
  }

  void onCreate(Database db, int version) {
    MoviesTable.createTable(db, version);
  }

  void updateStorage(Database db, int prevVersion, int nextVersion) {}

  Future insertMoviesList(List<MovieItemDto> moviesList) async {
    for (MovieItemDto movie in moviesList) {
      bool movieExists = await checkIFExists(movie.imdbID);
      if (!movieExists) {
        insertSingleMovie(movie);
      }
    }
  }

  Future<bool> checkIFExists(String imdbID) async {
    final Database db = await database;
    List<Map<String, dynamic>> movieItem = await db.query(
        MoviesTable.MOVIES_TABLE_NAME,
        limit: 1,
        where: 'imdbID = ?',
        whereArgs: [imdbID]
    );
    // List<Map<String, dynamic>> movieItemRow = await db.rawQuery(
    //     'SELECT imdbID FROM "${MoviesTable.MOVIES_TABLE_NAME}" WHERE imdbID = $imdbID LIMIT 1');
    print("movie item in the db: $movieItem");
    return movieItem.isNotEmpty;
  }

  Future<int> getTotalLength() async {
    final Database db = await database;
    String query = 'SELECT COUNT(*) FROM ${MoviesTable.MOVIES_TABLE_NAME}';
    List<Map<String, dynamic>> total = await db.rawQuery(query);
    return total.first["COUNT(*)"];
  }

  Future<MoviesListModel?> getSavedMoviesList(int page) async {
    final Database db = await database;
    List<Map<String, dynamic>> moviesMaps = await db.query(
      MoviesTable.MOVIES_TABLE_NAME,
      columns: ['Title', 'Year', 'imdbID', 'Type', 'Poster'],
      limit: 10,
      offset: (page - 1) * 10
    );
    if (moviesMaps.isNotEmpty) {
      return MoviesListModel(
          Search: moviesMaps.map((savedItem) => MovieItemDto.fromMap(savedItem)).toList(),
          totalResults: (page * 10).toString(),
          Response: ''
      );
    }
    return null;
  }

  Future<MoviesListModel?> filterSavedMoviesList(String filterString, int page) async {
    final Database db = await database;
    List<Map<String, dynamic>> moviesMaps = await db.query(
        MoviesTable.MOVIES_TABLE_NAME,
        where: "Title LIKE '%$filterString%'",
        limit: 10,
        offset: (page - 1) * 10
    );

    String query = 'SELECT COUNT(*) FROM ${MoviesTable.MOVIES_TABLE_NAME} WHERE Title LIKE "%$filterString%"';
    List<Map<String, dynamic>> total = await db.rawQuery(query);
    int num = total.first["COUNT(*)"];

    if (moviesMaps.isNotEmpty) {
      return MoviesListModel(
          Search: moviesMaps.map((savedItem) => MovieItemDto.fromMap(savedItem)).toList(),
          totalResults: num.toString(),
          Response: ''
      );
    }
    return MoviesListModel(
        Search: [],
        totalResults: num.toString(),
        Response: ''
    );
  }

  Future<MovieItemDto> insertSingleMovie(MovieItemDto movieItem) async {
    final Database db = await database;
    int insertedIdx = await db.insert(
        MoviesTable.MOVIES_TABLE_NAME,
        movieItem.toMap()
    );
    return movieItem;
  }

  Future<MovieItemDto?> getSingleMovie(String imdbID) async {
    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
        MoviesTable.MOVIES_TABLE_NAME,
        distinct: true,
        columns: ['Title', 'Year', 'imdbID', 'Type', 'Poster'],
        where: 'imdbID = ?',
        whereArgs: [imdbID]
    );
    if (maps.isNotEmpty) {
      return MovieItemDto.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(String imdbID) async {
    final Database db = await database;
    return await db.delete(
        MoviesTable.MOVIES_TABLE_NAME,
        where: 'imdbID = ?',
        whereArgs: [imdbID]
    );
  }

  Future<int> update(MovieItemDto movieItem) async {
    final Database db = await database;
    return await db.update(
        MoviesTable.MOVIES_TABLE_NAME,
        movieItem.toMap(),
        where: 'imdbID = ?',
        whereArgs: [movieItem.imdbID]
    );
  }
}