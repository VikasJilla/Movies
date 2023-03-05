import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:movies/core/local_storage/no_sql_storage.dart';
import 'package:movies/core/logger.dart';
import 'package:movies/core/services/movies_service.dart';
import 'package:movies/core/state_management/cubit_state.dart';
import 'package:movies/features/generic_widgets/vertical_space.dart';
import 'package:movies/features/generic_widgets/wait_widget.dart';
import 'package:movies/features/movies/cubit/movie_detail_cubit.dart';
import 'package:movies/features/movies/cubit/movie_states.dart';
import 'package:movies/features/movies/data_sources/movies_local_data_source.dart';
import 'package:movies/features/movies/data_sources/movies_remote_data_source.dart';
import 'package:movies/features/movies/movies_repository.dart';
import 'package:movies/features/repo_result.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/movie_detailed.dart';
import 'package:movies/models/rating.dart';

import '../../../core/ui_utils.dart';
import '../cubit/events.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  final bool isFavourite;
  const MovieDetailScreen(
      {super.key, required this.movie, required this.isFavourite});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailCubit(
        MoviesRepository(
          MoviesRemoteDataSource(
            MoviesService(),
          ),
          MoviesLocalDataSource(
            KiwiContainer().resolve<NoSqlStorageContract>(),
          ),
        ),
        isFavourite,
      )..add(LoadDetailsEvent(movie.title)),
      child: MovieDetailPage(
        title: movie.title,
      ),
    );
  }
}

class MovieDetailPage extends StatelessWidget {
  final String title;
  const MovieDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          //we could make this a generic widget or can configure its style using theme
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          BlocConsumer<MovieDetailCubit, CubitState>(
            listener: (context, state) {
              if (state is AddedToFavourites ||
                  state is RemovedFromFavourites) {
                logger.i("$state in state");
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state is RemovedFromFavourites
                      ? "Removed from Favorites"
                      : "Successfully added to Favourites"),
                ));
              } else if (state is CubitFailureState &&
                  state.error is RepoError) {
                showMessageDialog(
                    context: context,
                    message: (state.error as RepoError).message,
                    callback: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
              }
            },
            buildWhen: (previous, current) => current is! CubitFailureState,
            builder: (context, state) => FavouriteWidget(
              isFavourite: context.read<MovieDetailCubit>().isFavourite,
              state: state,
              onPressed: () {
                final movie = context.read<MovieDetailCubit>().movieDetailed;
                if (movie == null) return;
                context
                    .read<MovieDetailCubit>()
                    .add(AddToFavouriteEvent(movie));
              },
            ),
          )
        ],
      ),
      body: BlocBuilder<MovieDetailCubit, CubitState>(
          buildWhen: (previous, current) =>
              current is! AddToFavouriteEvent &&
              current is! AddedToFavourites &&
              current is! RemovedFromFavourites &&
              current is! AddingToFavourites,
          builder: (context, state) {
            return SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is! CubitSuccessState)
                    const WaitWidget()
                  else
                    _MovieDetailView(
                      movieDetailed: state.result,
                      key: Key(state.result.toString()),
                    )
                ],
              ),
            );
          }),
    );
  }
}

class _MovieDetailView extends StatelessWidget {
  final MovieDetailed movieDetailed;
  const _MovieDetailView({super.key, required this.movieDetailed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              movieDetailed.poster,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          const VSpace(height: 20),
          Text(
            movieDetailed.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const VSpace(height: 8),
          Text('Year: ${movieDetailed.year}'),
          const VSpace(height: 8),
          if (movieDetailed.runTime != null) ...[
            Text(movieDetailed.runTime!),
            const VSpace(height: 8),
          ],
          Text(movieDetailed.actors),
          const VSpace(height: 8),
          for (Rating r in movieDetailed.ratings) _RatingsView(rating: r),
          const VSpace(height: 8),
          Text(movieDetailed.plot),
        ],
      ),
    );
  }
}

class _RatingsView extends StatelessWidget {
  final Rating rating;
  const _RatingsView({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Text('${rating.source}: ${rating.value}');
  }
}

class FavouriteWidget extends StatelessWidget {
  final bool isFavourite;
  final CubitState state;
  final Function() onPressed;
  const FavouriteWidget(
      {super.key,
      required this.isFavourite,
      required this.state,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (state is CubitSuccessState ||
        state is AddedToFavourites ||
        state is RemovedFromFavourites) {
      return IconButton(
        onPressed: onPressed,
        icon: Icon(
          isFavourite ? Icons.favorite : Icons.favorite_border,
          color: isFavourite ? Colors.red : Colors.black,
        ),
      );
    }
    if (state is AddingToFavourites) return const WaitWidget();
    return const SizedBox(
      width: 0,
      height: 0,
    );
  }
}
