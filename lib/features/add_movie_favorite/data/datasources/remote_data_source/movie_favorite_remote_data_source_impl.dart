import 'package:cinema_club/core/errors/server_exception.dart';
import 'package:cinema_club/features/add_movie_favorite/data/datasources/remote_data_source/movie_favorite_remote_data_source.dart';
import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class MovieFavoriteRemoteDataSourceImpl
    implements MovieFavoriteRemoteDataSource {
  final FirebaseDatabase firebaseDatabase;
  final FirebaseAuth firebaseAuth;
  MovieFavoriteRemoteDataSourceImpl({
    required this.firebaseDatabase,
    required this.firebaseAuth,
  });

  @override
  Future<void> addRemoteMovieToFavorite(MovieFavoriteModel movie) async {
    final firebaseRef = firebaseDatabase.ref();
    final userAuth = firebaseAuth.currentUser;

    if (userAuth != null) {
      try {
        final value = {
          'movieId': movie.movieId,
          'orginalTitle': movie.orginalTitle,
          'title': movie.title,
          'overView': movie.overView,
          'tagLine': movie.tagLine,
          'relaeaseDate': movie.relaeaseDate,
          'posterPath': movie.posterPath,
          'voteAverage': movie.voteAverage,
          'voteCount': movie.voteCount,
          'geners': movie.geners
              .map((genre) => {
                    'id': genre.id,
                    'name': genre.name,
                  })
              .toList(),
        };
        await firebaseRef
            .child('users/${userAuth.uid}/MoviesFavorite/${movie.movieId}')
            .set(value);
      } on FirebaseException catch (e) {
        throw ServerException('${e.message}');
      }
    } else {
      throw ServerException('not found User');
    }
  }

  @override
  Future<void> deleteRemoteMovieFromFavorite(int movieId) async {
    final firebaseRef = firebaseDatabase.ref();
    final userAuth = firebaseAuth.currentUser;

    if (userAuth != null) {
      try {
        await firebaseRef
            .child('users/${userAuth.uid}/MoviesFavorite/$movieId')
            .remove();
      } on FirebaseException catch (e) {
        throw ServerException('${e.message}');
      }
    } else {
      throw ServerException('not found User');
    }
  }

  @override
  Future<List<MovieFavoriteModel>> getRemoteFavoriteMovies() async {
    final firebaseRef = firebaseDatabase.ref();
    final userAuth = firebaseAuth.currentUser;
    if (userAuth != null) {
      try {
        final snapshot = await firebaseRef
            .child('users/${userAuth.uid}/MoviesFavorite')
            .get();

        // Check if the snapshot contains any data
        if (snapshot.exists) {
          // Convert the snapshot data to a list of MovieFavoriteModel
          final data = snapshot.value as Map<dynamic, dynamic>;
          //print(data.entries.first.value);
          //print(data);

          // Use map to transform the data into a list of MovieFavoriteModel
          return data.entries.map((entry) {
            return MovieFavoriteModel.fromJson(
                entry.value as Map<dynamic, dynamic>);
          }).toList();
        } else {
          return []; // Return an empty list if no favorites found
        }
      } on FirebaseException catch (e) {
        throw ServerException('${e.message}');
      }
    } else {
      throw ServerException('User not found');
    }
  }
}
