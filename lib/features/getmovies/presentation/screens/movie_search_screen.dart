import 'package:cinema_club/features/geners/presentation/bloc/genre_bloc.dart';
import 'package:cinema_club/features/getmovies/presentation/widgets/loading_widget.dart';
import 'package:cinema_club/features/getmovies/presentation/widgets/movie_search_section.dart';
import 'package:cinema_club/features/moivesearch/presentation/bloc/movie_search_bloc.dart';
import 'package:cinema_club/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});
  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade900,
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GenreBloc>(
            create: (_) => sl<GenreBloc>()..add(GetGenresEvent())),
        BlocProvider<MovieSearchBloc>(create: (_) => sl<MovieSearchBloc>()),
      ],
      child: Column(
        children: [
          BlocBuilder<GenreBloc, GenreState>(
            builder: (context, state) {
              if (state is GenreLoading) {
                return const LoadingWidget();
              } else if (state is GenreLoaded) {
                return MovieSearchSection(
                    genere: state
                        .genres); // Placeholder for genres UI or an empty widget.
              } else {
                return Container(); // Handle other states such as error or initial.
              }
            },
          ),
        ],
      ),
    );
  }
}
