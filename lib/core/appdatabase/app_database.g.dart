// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieFavoriteDao? _daoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `favoriteMovies` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `movieId` INTEGER NOT NULL, `orginalTitle` TEXT NOT NULL, `title` TEXT NOT NULL, `overView` TEXT NOT NULL, `tagLine` TEXT NOT NULL, `relaeaseDate` TEXT NOT NULL, `posterPath` TEXT NOT NULL, `voteAverage` REAL NOT NULL, `voteCount` INTEGER NOT NULL, `geners` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieFavoriteDao get dao {
    return _daoInstance ??= _$MovieFavoriteDao(database, changeListener);
  }
}

class _$MovieFavoriteDao extends MovieFavoriteDao {
  _$MovieFavoriteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieFavoriteModelInsertionAdapter = InsertionAdapter(
            database,
            'favoriteMovies',
            (MovieFavoriteModel item) => <String, Object?>{
                  'id': item.id,
                  'movieId': item.movieId,
                  'orginalTitle': item.orginalTitle,
                  'title': item.title,
                  'overView': item.overView,
                  'tagLine': item.tagLine,
                  'relaeaseDate': item.relaeaseDate,
                  'posterPath': item.posterPath,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount,
                  'geners': _genresConverter.encode(item.geners)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieFavoriteModel>
      _movieFavoriteModelInsertionAdapter;

  @override
  Future<List<MovieFavoriteModel>> getMovies() async {
    return _queryAdapter.queryList('SELECT * FROM favoriteMovies',
        mapper: (Map<String, Object?> row) => MovieFavoriteModel(
            id: row['id'] as int?,
            movieId: row['movieId'] as int,
            orginalTitle: row['orginalTitle'] as String,
            title: row['title'] as String,
            overView: row['overView'] as String,
            tagLine: row['tagLine'] as String,
            relaeaseDate: row['relaeaseDate'] as String,
            posterPath: row['posterPath'] as String,
            voteAverage: row['voteAverage'] as double,
            voteCount: row['voteCount'] as int,
            geners: _genresConverter.decode(row['geners'] as String)));
  }

  @override
  Future<void> deleteMovieFromFavorite(int movieId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM favoriteMovies WHERE movieId = ?1',
        arguments: [movieId]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('Delete From favoriteMovies');
  }

  @override
  Future<void> addMovietoFavorite(MovieFavoriteModel moive) async {
    await _movieFavoriteModelInsertionAdapter.insert(
        moive, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _genresConverter = GenresConverter();
