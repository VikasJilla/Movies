import 'package:kiwi/kiwi.dart';
import 'package:movies/core/network_info.dart';
import 'package:movies/core/services/movies_service.dart';
import 'package:movies/models/movie_detailed.dart';

import '../../../core/constants/json_keys.dart';
import '../../../core/exceptions/no_network_exception.dart';
import '../../../models/movie.dart';

abstract class MoviesRemoteDataSourceContract {
  Future<List<Movie>> searchFor(String title);
  Future<MovieDetailed> fetchDetails(String title);
}

class MoviesRemoteDataSource extends MoviesRemoteDataSourceContract {
  final MoviesService service;

  MoviesRemoteDataSource(this.service);

  @override
  Future<MovieDetailed> fetchDetails(String title) async {
    if (await KiwiContainer().resolve<NetworkConnection>().isConnected()) {
      final response = await service.movieDetails(title);
      return MovieDetailed.fromJson(response.body);
    } else {
      throw NoNetworkException();
    }
  }

  @override
  Future<List<Movie>> searchFor(String title) async {
    if (await KiwiContainer().resolve<NetworkConnection>().isConnected()) {
      final response = await service.searchFor(title);
      if (response.body[JsonKeys.search] == null) return [];
      final List<Map<String, dynamic>> results =
          List<Map<String, dynamic>>.from(response.body[JsonKeys.search]);
      return results.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw NoNetworkException();
    }
  }
}
