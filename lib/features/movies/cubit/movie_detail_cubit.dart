import 'package:movies/core/state_management/cubit_state.dart';
import 'package:movies/core/state_management/safe_bloc.dart';
import 'package:movies/features/movies/cubit/events.dart';
import 'package:movies/features/movies/data_sources/movies_local_data_source.dart';
import 'package:movies/features/movies/data_sources/movies_remote_data_source.dart';
import 'package:movies/features/movies/movies_repository.dart';
import 'package:movies/models/movie_detailed.dart';

import 'movie_states.dart';

class MovieDetailCubit extends SafeBloc {
  final MoviesRepository repository;
  MovieDetailed? movieDetailed;
  bool isFavourite;
  MovieDetailCubit(this.repository, this.isFavourite)
      : super(const CubitInitialState()) {
    on<LoadDetailsEvent>((event, emit) async {
      final repoResult = await repository.fetchMovieDetails(event.title);
      if (repoResult.success) {
        movieDetailed = repoResult.result;
        emit(CubitSuccessState(repoResult.result));
      } else {
        emit(CubitFailureState(repoResult.result));
      }
    });
    on<AddToFavouriteEvent>(
      (event, emit) async {
        emit(AddingToFavourites());
        isFavourite = !isFavourite;
        await repository.updateFavourite(event.movieDetailed, isFavourite);
        emit(isFavourite ? AddedToFavourites() : RemovedFromFavourites());
      },
    );
  }
}
