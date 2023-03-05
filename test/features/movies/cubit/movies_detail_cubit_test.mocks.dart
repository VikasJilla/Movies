// Mocks generated by Mockito 5.3.2 from annotations
// in movies/test/features/movies/cubit/movies_detail_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movies/features/movies/data_sources/movies_local_data_source.dart'
    as _i3;
import 'package:movies/features/movies/data_sources/movies_remote_data_source.dart'
    as _i2;
import 'package:movies/features/movies/movies_repository.dart' as _i5;
import 'package:movies/features/repo_result.dart' as _i4;
import 'package:movies/models/movie_detailed.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMoviesRemoteDataSourceContract_0 extends _i1.SmartFake
    implements _i2.MoviesRemoteDataSourceContract {
  _FakeMoviesRemoteDataSourceContract_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMoviesLocalDataSourceContract_1 extends _i1.SmartFake
    implements _i3.MoviesLocalDataSourceContract {
  _FakeMoviesLocalDataSourceContract_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRepoResult_2<T> extends _i1.SmartFake implements _i4.RepoResult<T> {
  _FakeRepoResult_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MoviesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesRepository extends _i1.Mock implements _i5.MoviesRepository {
  MockMoviesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MoviesRemoteDataSourceContract get moviesRemoteDataSource =>
      (super.noSuchMethod(
        Invocation.getter(#moviesRemoteDataSource),
        returnValue: _FakeMoviesRemoteDataSourceContract_0(
          this,
          Invocation.getter(#moviesRemoteDataSource),
        ),
      ) as _i2.MoviesRemoteDataSourceContract);
  @override
  _i3.MoviesLocalDataSourceContract get moviesLocalDataSource =>
      (super.noSuchMethod(
        Invocation.getter(#moviesLocalDataSource),
        returnValue: _FakeMoviesLocalDataSourceContract_1(
          this,
          Invocation.getter(#moviesLocalDataSource),
        ),
      ) as _i3.MoviesLocalDataSourceContract);
  @override
  _i6.Future<_i4.RepoResult<dynamic>> getFavourites() => (super.noSuchMethod(
        Invocation.method(
          #getFavourites,
          [],
        ),
        returnValue: _i6.Future<_i4.RepoResult<dynamic>>.value(
            _FakeRepoResult_2<dynamic>(
          this,
          Invocation.method(
            #getFavourites,
            [],
          ),
        )),
      ) as _i6.Future<_i4.RepoResult<dynamic>>);
  @override
  _i6.Future<_i4.RepoResult<dynamic>> searchForMovies(String? title) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchForMovies,
          [title],
        ),
        returnValue: _i6.Future<_i4.RepoResult<dynamic>>.value(
            _FakeRepoResult_2<dynamic>(
          this,
          Invocation.method(
            #searchForMovies,
            [title],
          ),
        )),
      ) as _i6.Future<_i4.RepoResult<dynamic>>);
  @override
  _i6.Future<_i4.RepoResult<dynamic>> fetchMovieDetails(String? title) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchMovieDetails,
          [title],
        ),
        returnValue: _i6.Future<_i4.RepoResult<dynamic>>.value(
            _FakeRepoResult_2<dynamic>(
          this,
          Invocation.method(
            #fetchMovieDetails,
            [title],
          ),
        )),
      ) as _i6.Future<_i4.RepoResult<dynamic>>);
  @override
  _i6.Future<_i4.RepoResult<dynamic>> updateFavourite(
    _i7.MovieDetailed? favourite,
    bool? add,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateFavourite,
          [
            favourite,
            add,
          ],
        ),
        returnValue: _i6.Future<_i4.RepoResult<dynamic>>.value(
            _FakeRepoResult_2<dynamic>(
          this,
          Invocation.method(
            #updateFavourite,
            [
              favourite,
              add,
            ],
          ),
        )),
      ) as _i6.Future<_i4.RepoResult<dynamic>>);
  @override
  _i6.Stream<dynamic> listenToFavourites() => (super.noSuchMethod(
        Invocation.method(
          #listenToFavourites,
          [],
        ),
        returnValue: _i6.Stream<dynamic>.empty(),
      ) as _i6.Stream<dynamic>);
}