import 'package:movies/core/exceptions/no_network_exception.dart';
import 'package:movies/core/exceptions/server_exception.dart';
import 'package:movies/features/movies/data_sources/movies_local_data_source.dart';
import 'package:movies/features/repo_result.dart';
import 'package:movies/models/movie_detailed.dart';

import 'data_sources/movies_remote_data_source.dart';

typedef AsyncFunction = Future<dynamic> Function();

class MoviesRepository {
  final MoviesRemoteDataSourceContract moviesRemoteDataSource;
  final MoviesLocalDataSourceContract moviesLocalDataSource;

  MoviesRepository(
    this.moviesRemoteDataSource,
    this.moviesLocalDataSource,
  );

  Future<RepoResult> getFavourites() async {
    return _fetchResult(moviesLocalDataSource.getFavourites);
  }

  Future<RepoResult> searchForMovies(String title) async {
    return _fetchResult(
      () async => await moviesRemoteDataSource.searchFor(title),
    );
  }

  Future<RepoResult> fetchMovieDetails(String title) async {
    return _fetchResult(
        () async => await moviesRemoteDataSource.fetchDetails(title));
  }

  Future<RepoResult> updateFavourite(MovieDetailed favourite, bool add) {
    return _fetchResult(() async {
      return await moviesLocalDataSource.updateFavourite(favourite, add);
    });
  }

  Stream listenToFavourites() {
    return moviesLocalDataSource.favouritesStream();
  }

  Future<RepoResult> _fetchResult(AsyncFunction callback) async {
    try {
      return RepoResult(true, await callback());
    } on NoNetworkException {
      return RepoResult(false, RepoError('No Network'));
    } on ServerException catch (e) {
      return RepoResult(false, RepoError('${e.statusCode} ${e.body}'));
    } catch (e) {
      return RepoResult(false, RepoError('Something went wrong'));
    }
  }
}
