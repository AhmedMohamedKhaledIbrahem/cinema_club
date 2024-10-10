import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_club/constants/string/route_name.dart';
import 'package:cinema_club/constants/string/string.dart';
import 'package:cinema_club/features/add_movie_favorite/data/models/movie_favorite_model.dart';
import 'package:cinema_club/features/add_movie_favorite/presentation/bloc/movie_favorite_bloc.dart';
import 'package:cinema_club/features/moviedetails/presentation/bloc/movie_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieFavoriteScreen extends StatefulWidget {
  const MovieFavoriteScreen({super.key});
  @override
  State<MovieFavoriteScreen> createState() => _MovieFavoriteScreenState();
}

class _MovieFavoriteScreenState extends State<MovieFavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieFavoriteBloc>().add(GetFavoriteMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildFavoriteMovies(),
    );
  }

  buildFavoriteMovies() {
    return BlocBuilder<MovieFavoriteBloc, MovieFavoriteState>(
      builder: (context, state) {
        //print(state.runtimeType);
        if (state is MovieFavoirteLoaded) {
          return listViewBuilder(state);
        } else if (state is MovieFavoirteError) {
        } else if (state is MovieFavoirteDelete) {
          context.read<MovieFavoriteBloc>().add(GetFavoriteMoviesEvent());
        }
        return Container();
      },
    );
  }

  listViewBuilder(MovieFavoirteLoaded state) {
    return ListView.builder(
      itemCount: state.moviesFavorite.length,
      itemBuilder: (context, index) {
        final favoirteMovie = state.moviesFavorite[index];
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            context
                .read<MovieDetailsBloc>()
                .add(MovieDetailsByIdEvent(id: favoirteMovie.movieId));
            Navigator.pushNamed(context, moiveDetalesScreen);
          },
          child: favoirteMovieCard(context, favoirteMovie),
        );
      },
    );
  }

  favoirteMovieCard(BuildContext context, MovieFavoriteModel favoirteMovie) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        elevation: 10,
        child: Row(
          children: [
            posterImageCard(favoirteMovie),
            movieDetailsCard(context, favoirteMovie),
          ],
        ),
      ),
    );
  }

  posterImageCard(MovieFavoriteModel favoirteMovie) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: posterPath + favoirteMovie.posterPath,
        imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.26,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          ),
        ),
        placeholder: (context, url) => Skeletonizer(
          enableSwitchAnimation: true,
          enabled: true,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.26,
            color: Colors.grey.shade800,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          alignment: Alignment.center,
          child: const Icon(Icons.image_not_supported_outlined),
        ),
      ),
    );
  }

  movieDetailsCard(BuildContext context, MovieFavoriteModel favoirteMovie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.66,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              favoirteMovie.title,
              style:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            Text(
              favoirteMovie.overView,
              style:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(height: 2),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  buildMovieListSkeleton(int itemCount) {
    return ListView.builder(
      itemCount: itemCount, // Use the dynamic count here
      itemBuilder: (context, index) {
        return SkeletonLoader(
          builder: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              elevation: 10,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.29,
                    height: MediaQuery.of(context).size.height * 0.26,
                    color: Colors.grey[300], // Skeleton placeholder for image
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, bottom: 10.0, top: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 20,
                          color: Colors
                              .grey[300], // Skeleton placeholder for title
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 60,
                          color: Colors
                              .grey[300], // Skeleton placeholder for overview
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          highlightColor: Colors.grey[100]!,
          direction: SkeletonDirection.ltr,
        );
      },
    );
  }
}
