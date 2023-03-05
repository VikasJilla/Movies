import 'package:movies/features/movies/cubit/events.dart';
import 'package:movies/features/movies/movies_repository.dart';
import 'package:movies/models/movie_detailed.dart';

import '../../../core/state_management/cubit_state.dart';
import '../../../core/state_management/safe_bloc.dart';

class SearchCubit extends SafeBloc {
  final MoviesRepository repository;
  final List<MovieDetailed> favourites = [];
  String _searchQuery = '';

  SearchCubit(this.repository) : super(const CubitInitialState()) {
    repository.listenToFavourites().listen((event) {
      favourites.clear();
      favourites.addAll(List<Map<String, dynamic>>.from(event)
          .map((e) => MovieDetailed.fromJson(e)));
    });
    on<LoadFavouritesEvent>((event, emit) async {
      _searchQuery = '';
      emit(CubitSuccessState(favourites));
    });
    on<SearchEvent>((event, emit) async {
      emit(const CubitLoadingState());
      _searchQuery = event.text;
      final repoResult = await repository.searchForMovies(event.text);
      if (repoResult.success) {
        emit(CubitSuccessState(repoResult.result));
      } else {
        emit(CubitFailureState(repoResult.result));
      }
    });
    loadFavourites();
  }

  Future<void> loadFavourites() async {
    emit(const CubitLoadingState());
    final repoResult = await repository.getFavourites();
    if (repoResult.success) {
      favourites.clear();
      favourites.addAll(repoResult.result);
      emit(CubitSuccessState(favourites));
    } else {
      emit(CubitFailureState(repoResult.result));
    }
  }

  bool get isSearchFieldEmpty => _searchQuery.isEmpty;
}
