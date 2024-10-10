import 'package:cinema_club/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/moviesbloc/movies_bloc.dart';
import '../widgets/widgets.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({
    super.key,
  });

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade900,
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              if (state is MoviesInitial) {
                return const LoadingWidget();
              } else if (state is MoviesLoading) {
                return const LoadingWidget();
              } else if (state is MoviesLoaded) {
                return Column(
                  children: [
                    MoviesDisplay(
                      movies: state.allMovies,
                      title: S.of(context).allMoviesLabel,
                      event: GetMoviesEvent(),
                    ),
                    const SizedBox(height: 16),
                    MoviesDisplay(
                      movies: state.upcomingMovies,
                      title: S.of(context).upcomingMoviesLabel,
                      event: GetUpcomingMoviesEvent(),
                    ),
                    const SizedBox(height: 16),
                    MoviesDisplay(
                      movies: state.topRatedMovies,
                      title: S.of(context).topRatedMoviesLabel,
                      event: GetTopRatedMoviesEvent(),
                    ),
                    const SizedBox(height: 16),
                    MoviesDisplay(
                      movies: state.popularMovies,
                      title: S.of(context).popularMoviesLabel,
                      event: GetPopularMoviesEvent(),
                    ),
                  ],
                );
              } else if (state is MoviesError) {
                //return MessageDisplay(message: state.message);
                return const LoadingWidget();
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
          // const TriviaControls()
        ],
      ),
    );
  }
}
