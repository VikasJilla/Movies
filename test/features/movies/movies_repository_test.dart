/*
Tests Covered:
✓ test fetch movies test if remote data sources searchFor is called
✓ test fetch movies test success for searching
✓ test fetch movies test failure for searching
*/
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/core/exceptions/server_exception.dart';
import 'package:movies/features/movies/data_sources/movies_local_data_source.dart';
import 'package:movies/features/movies/data_sources/movies_remote_data_source.dart';
import 'package:movies/features/movies/movies_repository.dart';
import 'package:movies/features/repo_result.dart';
import 'package:movies/models/movie.dart';

import 'movies_repository_test.mocks.dart';

@GenerateMocks([MoviesRemoteDataSourceContract, MoviesLocalDataSourceContract])
void main() {
  final mockRemoteSource = MockMoviesRemoteDataSourceContract();
  final mockLocalSource = MockMoviesLocalDataSourceContract();
  final movieRepository = MoviesRepository(mockRemoteSource, mockLocalSource);

  group("test fetch movies", () {
    const successTitle = "star";
    const failureTitle = "fff";
    setUp(() {
      when(mockRemoteSource.searchFor(successTitle))
          .thenAnswer((realInvocation) async => [
                Movie("Star wars 1", "2021", ""),
              ]);
      when(mockRemoteSource.searchFor(failureTitle))
          .thenAnswer((realInvocation) async => throw ServerException(400, ''));
    });
    test("test if remote data sources searchFor is called", () {
      movieRepository.searchForMovies(successTitle);
      verify(mockRemoteSource.searchFor(successTitle)).called(1);
    });

    test("test success for searching", () async {
      final repoResult = await movieRepository.searchForMovies(successTitle);
      expect(repoResult.success, true);
      expect(repoResult.result.length, 1);
    });

    test("test failure for searching", () async {
      final repoResult = await movieRepository.searchForMovies(failureTitle);
      expect(repoResult.success, false);
      expect(repoResult.result, isA<RepoError>());
    });
  });
}
