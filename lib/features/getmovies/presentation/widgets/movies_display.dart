import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../constants/string/route_name.dart';
import '../../../../constants/string/string.dart';
import '../../../moviedetails/presentation/bloc/movie_details_bloc.dart';

import 'package:flutter/material.dart';
import '../../domain/entities/movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/moviesbloc/movies_bloc.dart';

class MoviesDisplay extends StatefulWidget {
  final List<Movies> movies;
  final String title;
  final MoviesEvent event;

  const MoviesDisplay({
    super.key,
    required this.movies,
    required this.title,
    required this.event,
  });

  @override
  State<MoviesDisplay> createState() => _MoviesDisplayState();
}

class _MoviesDisplayState extends State<MoviesDisplay> {
  late ScrollController _scrollController;
  late List<Movies> _listMovies;

  @override
  void initState() {
    super.initState();
    _listMovies = widget.movies;
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // When user reaches the end of the list, fetch more movies
      context.read<MoviesBloc>().add(widget.event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoviesBloc, MoviesState>(
      listener: (context, state) {
        if (state is MoviesLoaded) {
          //setState(() {});
          // Update the listMovies with the new data from state

          switch (widget.event) {
            case GetMoviesEvent():
              _listMovies = state.allMovies;
              break;
            case GetPopularMoviesEvent():
              _listMovies = state.popularMovies;
              break;
            case GetUpcomingMoviesEvent():
              _listMovies = state.upcomingMovies;
              break;
            case GetTopRatedMoviesEvent():
              _listMovies = state.topRatedMovies;
              break;
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, top: 40),
            child: Text(widget.title,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          moviesItemBuilder(context),
        ],
      ),
    );
  }

  SizedBox moviesItemBuilder(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _listMovies.length,
        itemBuilder: (context, index) {
          final movie = _listMovies[index];
          return imageMovies(movie);
        },
      ),
    );
  }

  Padding imageMovies(Movies movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          context
              .read<MovieDetailsBloc>()
              .add(MovieDetailsByIdEvent(id: movie.id));
          Navigator.pushNamed(context, moiveDetalesScreen);
        },
        child: Card(
          color: Colors.grey.shade900,
          elevation: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: posterPath + movie.posterPath,
              imageBuilder: (context, imageProvider) => Container(
                width: 200,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Skeletonizer(
                enableSwitchAnimation: true,
                enabled: true,
                child: Container(
                  width: 200,
                  height: MediaQuery.of(context).size.height * 0.4,
                  color: Colors.grey.shade800,
                ),
              ),
              errorWidget: (context, url, error) => SizedBox(
                width: 200,
                height: MediaQuery.of(context).size.height * 0.35,
                child: const Icon(Icons.image_not_supported_outlined),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
