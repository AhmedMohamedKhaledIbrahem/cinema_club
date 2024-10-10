import 'package:cinema_club/features/add_movie_favorite/data/datasources/remote_data_source/movie_favorite_remote_data_source.dart';
import 'package:cinema_club/features/add_movie_favorite/data/datasources/remote_data_source/movie_favorite_remote_data_source_impl.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/add_remote_movie_to_favorite.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/delete_all.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/delete_remote_movie_to_favoirte.dart';
import 'package:cinema_club/features/add_movie_favorite/domain/usecases/get_remote_favorite_movies.dart';
import 'package:cinema_club/features/authentication/domain/usecases/update_send_verificationState.dart';
import 'package:cinema_club/features/profileuser/domain/usecases/upload_profile_user_photo.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/appdatabase/app_database.dart';
import 'core/network/network_info.dart';
import 'core/network/network_info_impl.dart';
import 'features/add_movie_favorite/data/datasources/local_data_source/Movie_favorite_local_data_source_impl.dart';
import 'features/add_movie_favorite/data/datasources/local_data_source/movie_favorite_dao.dart';
import 'features/add_movie_favorite/data/datasources/local_data_source/movie_favorite_local_data_source.dart';
import 'features/add_movie_favorite/data/repositories/movie_favorite_repository_impl.dart';
import 'features/add_movie_favorite/domain/repositories/movie_favorite_repository.dart';
import 'features/add_movie_favorite/domain/usecases/add_movie_to_favorite.dart';
import 'features/add_movie_favorite/domain/usecases/delete_movie_from_favorite.dart';
import 'features/add_movie_favorite/domain/usecases/get_favorite_movies.dart';
import 'features/add_movie_favorite/presentation/bloc/movie_favorite_bloc.dart';
import 'features/authentication/data/datasources/user_remote_data_source.dart';
import 'features/authentication/data/datasources/user_remote_data_source_impl.dart';
import 'features/authentication/data/repositories/user_repository_impl.dart';
import 'features/authentication/domain/repositories/user_repository.dart';
import 'features/authentication/domain/usecases/login.dart';
import 'features/authentication/domain/usecases/login_with_facebook.dart';
import 'features/authentication/domain/usecases/login_with_google.dart';
import 'features/authentication/domain/usecases/reset_password.dart';
import 'features/authentication/domain/usecases/send_email_verification.dart';
import 'features/authentication/domain/usecases/signout.dart';
import 'features/authentication/domain/usecases/signup.dart';
import 'features/authentication/domain/usecases/store_user_data.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/geners/data/datasources/geners_remote_data_source.dart';
import 'features/geners/data/datasources/geners_remote_data_source_impl.dart';
import 'features/geners/data/repositories/geners_repository_impl.dart';
import 'features/geners/domain/repositories/genre_repository.dart';
import 'features/geners/domain/usecases/get_genre.dart';
import 'features/geners/presentation/bloc/genre_bloc.dart';
import 'features/getmovies/data/datasources/movies_remote_data_source.dart';
import 'features/getmovies/data/datasources/movies_remote_data_source_impl.dart';
import 'features/getmovies/data/repositories/movie_repository_impl.dart';
import 'features/getmovies/domain/repositories/movie_repository.dart';
import 'features/getmovies/domain/usecases/find_movie_by_id.dart';
import 'features/getmovies/domain/usecases/get_moives.dart';
import 'features/getmovies/domain/usecases/get_popular_movies.dart';
import 'features/getmovies/domain/usecases/get_top_rated_movies.dart';
import 'features/getmovies/domain/usecases/get_upcoming_movies.dart';
import 'features/getmovies/presentation/bloc/findmoviesbloc/findmovies_bloc.dart';
import 'features/getmovies/presentation/bloc/moviesbloc/movies_bloc.dart';
import 'features/profileuser/data/datasources/profile_user_remote_data_source.dart';
import 'features/profileuser/data/datasources/profile_user_remote_data_source_impl.dart';
import 'features/profileuser/data/repositories/profile_user_repository_impl.dart';
import 'features/profileuser/domain/repositories/profile_user_repositories.dart';
import 'features/profileuser/domain/usecases/get_profile_user.dart';
import 'features/profileuser/presentation/bloc/profile_user_bloc.dart';
import 'features/moivesearch/data/datasources/movie_search_remote_data_source.dart';
import 'features/moivesearch/data/datasources/movie_search_remote_data_source_impl.dart';
import 'features/moivesearch/data/repositories/movie_search_repository_impl.dart';
import 'features/moivesearch/domain/repositories/movie_search_repository.dart';
import 'features/moivesearch/domain/usecases/movie_search_usecase.dart';
import 'features/moivesearch/presentation/bloc/movie_search_bloc.dart';
import 'features/moviedetails/data/datasources/movie_details_remote_data_source.dart';
import 'features/moviedetails/data/datasources/movie_details_remote_data_source_impl.dart';
import 'features/moviedetails/data/repositories/movie_details_repository_impl.dart';
import 'features/moviedetails/domain/repositories/movie_details_repository.dart';
import 'features/moviedetails/domain/usecases/movie_details_usecase.dart';
import 'features/moviedetails/presentation/bloc/movie_details_bloc.dart';
import 'features/setting/data/datasources/setting_local_data_source.dart';
import 'features/setting/data/datasources/setting_local_data_source_impl.dart';
import 'features/setting/data/repositories/settings_repository_impl.dart';
import 'features/setting/domain/repositories/setting_repository.dart';
import 'features/setting/domain/usecases/get_setting.dart';
import 'features/setting/domain/usecases/save_setting.dart';
import 'features/setting/presentation/bloc/setting_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Initialize the database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerLazySingleton<AppDatabase>(() => database);
  sl.registerLazySingleton<MovieFavoriteDao>(() => database.dao);
  //! Feature
  sl.registerFactory(
    () => MoviesBloc(
      getMoives: sl(),
      getPopularMovies: sl(),
      getTopRatedMovies: sl(),
      getUpcomingMovies: sl(),
    ),
  );
  sl.registerFactory(() => AuthenticationBloc(
        loginWithEmail: sl(),
        updateSendEmailVerification: sl(),
        loginWithGoogle: sl(),
        loginWithFacebook: sl(),
        signUp: sl(),
        verification: sl(),
        resetPassword: sl(),
        logout: sl(),
        storeUserData: sl(),
      ));
  sl.registerFactory(() => SettingBloc(getSetting: sl(), saveSetting: sl()));
  sl.registerFactory(() => ProfileUserBloc(
        getProfileUser: sl(),
        uploadProfileUserPhoto: sl(),
      ));
  sl.registerFactory(() => MovieDetailsBloc(movieDetails: sl()));
  sl.registerFactory(() => MovieSearchBloc(movie: sl()));
  sl.registerFactory(() => GenreBloc(getGenre: sl()));
  sl.registerFactory(() => FindmoviesBloc(findMovieById: sl()));
  sl.registerFactory(
    () => MovieFavoriteBloc(
      addMovieToFavorite: sl(),
      deleteMovieFromFavorite: sl(),
      getFavoriteMovies: sl(),
      addAemoteMovieToFavorite: sl(),
      deleteRemoteMovieToFavoirte: sl(),
      getRemoteFavoriteMovies: sl(),
      deleteAll: sl(),
    ),
  );
  //use case
  sl.registerLazySingleton(() => GetMoives(sl()));
  sl.registerLazySingleton(() => GetPopularMovies(sl()));
  sl.registerLazySingleton(() => GetTopRatedMovies(sl()));
  sl.registerLazySingleton(() => GetUpcomingMovies(sl()));
  sl.registerLazySingleton(() => FindMovieById(sl()));
  sl.registerLazySingleton(() => MovieDetailsUsecase(repository: sl()));
  sl.registerLazySingleton(() => MovieSearchUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetGenreUseCase(repository: sl()));
  sl.registerLazySingleton(() => Login(repository: sl()));
  sl.registerLazySingleton(() => LoginWithGoogle(repository: sl()));
  sl.registerLazySingleton(() => LoginWithFacebook(repository: sl()));
  sl.registerLazySingleton(() => SignUp(repository: sl()));
  sl.registerLazySingleton(() => Signout(repository: sl()));
  sl.registerLazySingleton(() => SendEmailVerification(repository: sl()));
  sl.registerLazySingleton(() => ResetPassword(repository: sl()));
  sl.registerLazySingleton(() => StoreUserData(repository: sl()));
  sl.registerLazySingleton(() => GetProfileUser(repositories: sl()));
  sl.registerLazySingleton(() => UploadProfileUserPhoto(repositories: sl()));
  sl.registerLazySingleton(() => GetSetting(repository: sl()));
  sl.registerLazySingleton(() => SaveSetting(repository: sl()));
  sl.registerLazySingleton(() => AddMovieToFavorite(repoistories: sl()));
  sl.registerLazySingleton(() => DeleteMovieFromFavorite(repoistories: sl()));
  sl.registerLazySingleton(() => GetFavoriteMovies(repoistories: sl()));
  sl.registerLazySingleton(() => UpdateSendVerificationstate(repository: sl()));
  sl.registerLazySingleton(() => DeleteRemoteMovieToFavoirte(repository: sl()));
  sl.registerLazySingleton(() => GetRemoteFavoriteMovies(repository: sl()));
  sl.registerLazySingleton(() => AddRemoteMovieToFavorite(repository: sl()));
  sl.registerLazySingleton(() => DeleteAll(repository: sl()));

  //repositories
  sl.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<MovieDetailsRepository>(() =>
      MovieDetailsRepositoryImpl(
          networkInfo: sl(), movieDetailsRemoteDataSource: sl()));
  sl.registerLazySingleton<MovieSearchRepository>(() =>
      MovieSearchRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<GenreRepository>(() =>
      GenersRepositoryImpl(genersRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<ProfileUserRepositories>(() =>
      ProfileUserRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<SettingRepository>(
      () => SettingsRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<MovieFavoriteRepository>(() =>
      MovieFavoriteRepositoryImpl(
          localDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()));

  //! Data sources
  sl.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<MovieDetailsRemoteDataSource>(
      () => MovieDetailsRemoteDataSourceImpl(dio: sl()));

  sl.registerLazySingleton<GenersRemoteDataSource>(
      () => GenersRemoteDataSourceImpl(dio: sl()));

  sl.registerLazySingleton<MovieSearchRemoteDataSource>(
      () => MovieSearchRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      firebaseAuth: sl(),
      databaseReference: sl(),
      googleSignIn: sl(),
      facebookAuth: sl(),
    ),
  );
  sl.registerLazySingleton<SettingLocalDataSource>(
      () => SettingLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<ProfileUserRemoteDataSource>(
    () => ProfileUserRemoteDataSourceImpl(
      firebaseDatabase: sl(),
      firebaseAuth: sl(),
      firebaseStorage: sl(),
    ),
  );
  sl.registerLazySingleton<MovieFavoriteLocalDataSource>(
      () => MovieFavoriteLocalDataSourceImpl(dao: sl()));
  sl.registerLazySingleton<MovieFavoriteRemoteDataSource>(() =>
      MovieFavoriteRemoteDataSourceImpl(
          firebaseDatabase: sl(), firebaseAuth: sl()));
  //! core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => FacebookAuth.instance);
  sl.registerLazySingleton<DatabaseReference>(
      () => FirebaseDatabase.instance.ref());
  sl.registerLazySingleton<FirebaseDatabase>(() => FirebaseDatabase.instance);
  sl.registerLazySingleton<FirebaseStorage>(() =>
      FirebaseStorage.instanceFor(bucket: 'gs://smartglass-b39ce.appspot.com'));
}
