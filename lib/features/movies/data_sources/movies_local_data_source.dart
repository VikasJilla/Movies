import 'package:movies/core/constants/string_constants.dart';
import 'package:movies/core/local_storage/no_sql_storage.dart';
import 'package:movies/models/movie_detailed.dart';

abstract class MoviesLocalDataSourceContract {
  Future<bool> updateFavourite(MovieDetailed movie, bool markFavourite);
  Future<List<MovieDetailed>> getFavourites();
  Stream favouritesStream();
}

class MoviesLocalDataSource implements MoviesLocalDataSourceContract {
  final NoSqlStorageContract _sqlStorageContract;

  MoviesLocalDataSource(this._sqlStorageContract);

  @override
  Future<bool> updateFavourite(MovieDetailed movie, bool markFavourite) async {
    final list = List<Map<String, dynamic>>.from(
        _sqlStorageContract.getValue(StringConstants.dbFavouritesKey) ?? []);
    if (markFavourite) {
      list.add(movie.toJson());
    } else {
      list.removeWhere((element) => element['Title'] == movie.title);
    }
    await _sqlStorageContract.setValue(StringConstants.dbFavouritesKey, list);
    return true;
  }

  @override
  Future<List<MovieDetailed>> getFavourites() async {
    return List<Map<String, dynamic>>.from(
            _sqlStorageContract.getValue(StringConstants.dbFavouritesKey) ?? [])
        .map((e) => MovieDetailed.fromJson(e))
        .toList();
  }

  @override
  Stream favouritesStream() {
    return _sqlStorageContract.listenToKey(StringConstants.dbFavouritesKey);
  }
}
