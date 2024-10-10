import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_club/constants/colors/colors.dart';
import 'package:cinema_club/features/add_movie_favorite/presentation/bloc/movie_favorite_bloc.dart';
import 'package:cinema_club/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/string/string.dart';
import '../../../moviedetails/domain/entities/movie_details_Entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MoiveDetailSection extends StatefulWidget {
  final MovieDetailsEntity movie;
  const MoiveDetailSection({super.key, required this.movie});

  @override
  State<MoiveDetailSection> createState() => _MoiveDetailSection();
}

class _MoiveDetailSection extends State<MoiveDetailSection> {
  late MovieDetailsEntity _movie;
  bool isFavorited = false;
  late StreamSubscription _favoriteSubscription;

  Future<void> loadFavoriteState(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    // Get the locally saved favorite state
    final localIsFavorited = prefs.getBool('isFavorited_$movieId') ?? false;

    // Update the UI based on local data first
    if (mounted) {
      setState(() {
        isFavorited = localIsFavorited;
      });
    }

    _favoriteSubscription =
        context.read<MovieFavoriteBloc>().stream.listen((state) {
      if (state is MovieFavoirteLoaded) {
        final remoteFavoriteMovies = state.moviesFavorite;
        final isMovieFavoritedRemotely =
            remoteFavoriteMovies.any((movie) => movie.movieId == movieId);

        // Update SharedPreferences and local state only if the remote state differs
        if (isMovieFavoritedRemotely != localIsFavorited) {
          setState(() {
            isFavorited = isMovieFavoritedRemotely;
            prefs.setBool('isFavorited_$movieId', isFavorited);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _favoriteSubscription.cancel();
    super.dispose();
  }

  //isFavorited = prefs.getBool('isFavorited_$movieId') ??
  //  false; // Default to false if not found
  Future<void> saveFavoriteState(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFavorited_$movieId', isFavorited);
  }

  @override
  void initState() {
    super.initState();
    _movie = widget.movie;
    loadFavoriteState(_movie.id);
  }

  void saveToFavoriteMovie() {
    context.read<MovieFavoriteBloc>().add(
          AddMovieToFavoriteEvent(movieDetailsEntity: _movie),
        );
    context.read<MovieFavoriteBloc>().add(
          AddRemoteMovieToFavoriteEvent(movieDetailsEntity: _movie),
        );
  }

  void deleteFromFavoriteMovie() {
    context.read<MovieFavoriteBloc>().add(
          DeleteMovieFromFavoriteEvent(movieId: _movie.id),
        );
    context.read<MovieFavoriteBloc>().add(
          DeleteRemoteMovieFromFavoriteEvent(movieId: _movie.id),
        );
  }

  void _toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited; // Toggle the state
      if (isFavorited) {
        saveToFavoriteMovie(); // Call save function when favorited
      } else {
        deleteFromFavoriteMovie(); // Call delete function when unfavorited
      }
      saveFavoriteState(_movie.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.cyan,
      body: Stack(
        children: [
          Container(
              //color: Colors.grey[800], // Set your desired background color here
              ),
          opacityImageBackground(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              iconsTop(context),
              const SizedBox(height: 60),
              imagePoster(),
              orginalTitle(),
              genresMovie(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: overViewMovie(),
              )
            ],
          )
        ],
      ),
    );
  }

  SizedBox overViewMovie() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
          child: Text(
            _movie.overView,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(height: 1.5, overflow: TextOverflow.clip),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }

  SizedBox genresMovie() {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _movie.geners.length,
        itemBuilder: (context, index) {
          final genre = _movie.geners[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.28,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Text(
                  genre.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding orginalTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Text(
        _movie.orginalTitle,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Padding imagePoster() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.red.withOpacity(0.7),
                    spreadRadius: 1,
                    blurRadius: 2)
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: posterPath + _movie.posterPath,
                imageBuilder: (context, imageProvider) => Container(
                  width: 200,
                  height: MediaQuery.of(context).size.height * 0.36,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  width: 200,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
          ),
          ratingMovieStars()
        ],
      ),
    );
  }

  Padding ratingMovieStars() {
    return Padding(
      padding: const EdgeInsets.only(top: 300, right: 15),
      child: Row(
        children: [
          Text(
            S.of(context).ratingLabel,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          RatingBarIndicator(
            rating: _movie.voteAverage,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber[900],
            ),
            itemCount: 8,
            itemSize: 14,
            direction: Axis.horizontal,
          ),
        ],
      ),
    );
  }

  Padding iconsTop(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: MyColors.accentBlue,
              size: 30,
            ),
          ),
          InkWell(
            onTap: _toggleFavorite,
            child: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : MyColors.accentBlue,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

  SizedBox opacityImageBackground() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Opacity(
        opacity: 1,
        child: CachedNetworkImage(
          imageUrl: posterPath + _movie.posterPath,
          imageBuilder: (context, imageProvider) => Container(
            //width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => SizedBox(
            width: 200,
            height: MediaQuery.of(context).size.height * 0.35,
            child: const Icon(Icons.image_not_supported_outlined),
          ),
        ),
      ),
    );
  }
}
