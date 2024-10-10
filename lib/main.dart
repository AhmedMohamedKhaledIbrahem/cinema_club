import 'package:cinema_club/core/shared/theme_shared_preferences.dart';
import 'package:cinema_club/core/theme/theme.dart';
import 'package:cinema_club/features/add_movie_favorite/presentation/bloc/movie_favorite_bloc.dart';
import 'package:cinema_club/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:cinema_club/features/authentication/presentation/screens/login_screen.dart';
import 'package:cinema_club/features/getmovies/presentation/bloc/moviesbloc/movies_bloc.dart';
import 'package:cinema_club/features/setting/presentation/bloc/setting_bloc.dart';
import 'package:cinema_club/generated/intl/messages_all.dart';
import 'package:cinema_club/generated/l10n.dart';
import 'package:cinema_club/navigation_bottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_router.dart';
import 'features/moivesearch/presentation/bloc/movie_search_bloc.dart';
import 'features/moviedetails/presentation/bloc/movie_details_bloc.dart';
import 'injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  final themePrefs = ThemeSharedPreferences();
  themePrefs.init();
  await initializeMessages(PlatformDispatcher.instance.locale.languageCode);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPLhXfllMgY2fmb3q78iw7Q8aGXnmRjQE",
      appId: "1:688450515610:android:ef28d30f04d7607c662523",
      messagingSenderId: "688450515610",
      projectId: "smartglass-b39ce",
    ),
  );
  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final SettingBloc _settingBloc;
  @override
  void initState() {
    super.initState();

    _settingBloc = sl<SettingBloc>()..add(GetSettingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailsBloc>(
            create: (_) => sl<MovieDetailsBloc>(),
          ),
          BlocProvider<MovieSearchBloc>(
            create: (_) => sl<MovieSearchBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<AuthenticationBloc>(),
          ),
          BlocProvider(create: (context) => _settingBloc),
          BlocProvider(
              create: (context) =>
                  sl<MovieFavoriteBloc>()..add(GetFavoriteMoviesEvent())),
          BlocProvider(
              create: (_) => sl<MoviesBloc>()
                ..add(GetTopRatedMoviesEvent())
                ..add(GetUpcomingMoviesEvent())
                ..add(GetPopularMoviesEvent())
                ..add(GetMoviesEvent())),
        ],
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            if (state is SettingLoaded) {
              return MaterialApp(
                theme: state.settingEntity.isDarkMode
                    ? AppTheme.darkTheme()
                    : AppTheme.lightTheme(),
                locale: Locale(state.settingEntity.languageCode),
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('ar', 'SA'),
                ],
                /**/
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                onGenerateRoute: widget.appRouter.generateRoute,
                home: authStateChange(),
              );
            }
            return Container();
          },
        ));
  }

  StreamBuilder<User?> authStateChange() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        // If the stream has data, the user is logged in.
        //if (snapshot.connectionState == ConnectionState.waiting) {
        // return const Center(child: CircularProgressIndicator());
        // }

        // Handle potential error in the stream
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        }

        // Check the authentication state based on the user data
        final user = snapshot.data;
        if (user == null) {
          // User is signed out, show the login screen
          return const LoginScreen();
        } else {
          // User is signed in, show the movies navigation
          return const MoviesNav();
        }
      },
    );
  }
}
