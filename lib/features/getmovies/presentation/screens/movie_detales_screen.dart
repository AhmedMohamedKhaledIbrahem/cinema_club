import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../moviedetails/presentation/bloc/movie_details_bloc.dart';
import '../widgets/widgets.dart';

class MovieDetalesScreen extends StatefulWidget {
  const MovieDetalesScreen({super.key});

  @override
  State<MovieDetalesScreen> createState() => _MovieDetalesScreen();
}

class _MovieDetalesScreen extends State<MovieDetalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
      if (state is MovieDetailsInitial) {
        return Container();
      } else if (state is MovieDetailsLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is MovieDetailsLoaded) {
        return MoiveDetailSection(movie: state.movie);
      }
      return Container();
    });
  }
}
