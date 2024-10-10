import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_club/constants/string/route_name.dart';
import 'package:cinema_club/constants/string/string.dart';
import 'package:cinema_club/features/getmovies/presentation/widgets/widgets.dart';
import 'package:cinema_club/features/moivesearch/domain/entities/movie_search_Entity.dart';
import 'package:cinema_club/features/moivesearch/presentation/bloc/movie_search_bloc.dart';
import 'package:cinema_club/features/moviedetails/presentation/bloc/movie_details_bloc.dart';
import 'package:cinema_club/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../geners/domain/entities/genresEntities.dart';

class MovieSearchSection extends StatefulWidget {
  final List<GenresEntities> genere;

  const MovieSearchSection({
    super.key,
    required this.genere,
  });

  @override
  State<MovieSearchSection> createState() => _MovieSearchSectionState();
}

class _MovieSearchSectionState extends State<MovieSearchSection> {
  late List<GenresEntities> _genere;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _genere = widget.genere;
    _searchController.addListener(() {
      setState(() {});
      if (_searchController.text.isNotEmpty) {
        context.read<MovieSearchBloc>().add(MovieSearchAndGenreEvent(
            query: _searchController.text, genres: _genere));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          textFieldSearch(),
          Expanded(
            child: _searchController.text.isEmpty
                ? Center(
                    child: iconWhenEmpty(),
                  )
                : blocBuilderMovieSearch(),
          )
        ],
      ),
    );
  }

  iconWhenEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.magnifyingGlass,
          size: MediaQuery.of(context).size.width * 0.5,
        ),
        Text(S.of(context).NoSearchFoundLabel),
        const SizedBox(
          height: 130,
        )
      ],
    );
  }

  BlocBuilder<MovieSearchBloc, MovieSearchState> blocBuilderMovieSearch() {
    return BlocBuilder<MovieSearchBloc, MovieSearchState>(
      builder: (context, state) {
        if (state is MovieSearchLoading) {
          return const Center(child: LoadingWidget());
        } else if (state is MovieSearchLoaded && state.movieSearch.isNotEmpty) {
          return listViewBuilder(state);
        } else if (state is MovieSearchError) {
          return const Text('Error loading movies',
              style: TextStyle(color: Colors.red));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Expanded listViewBuilder(MovieSearchLoaded state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.movieSearch.length,
        itemBuilder: (context, index) {
          final movie = state.movieSearch[index];
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              context
                  .read<MovieDetailsBloc>()
                  .add(MovieDetailsByIdEvent(id: movie.id));
              Navigator.pushNamed(context, moiveDetalesScreen);
            },
            child: searchCard(movie, context),
          );
        },
      ),
    );
  }

  Padding textFieldSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: S.of(context).searchMoviesLabel,
          prefixIcon: const Icon(Icons.search),
          filled: true,
          //fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            // borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  SizedBox searchCard(MovieSearchEntity movie, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        elevation: 10,
        child: Row(
          children: [
            posterImageCard(movie),
            movieDetailsCard(context, movie),
          ],
        ),
      ),
    );
  }

  Padding movieDetailsCard(BuildContext context, MovieSearchEntity movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.62,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
            ),
            Text(
              'Genres: ${movie.genresName.join(',')}',
              style:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
            Text(
              movie.overView,
              style:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(height: 2),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  ClipRRect posterImageCard(MovieSearchEntity movie) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: posterPath + movie.posterPath,
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
}
