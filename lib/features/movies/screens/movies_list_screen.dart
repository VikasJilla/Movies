import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:movies/core/local_storage/no_sql_storage.dart';
import 'package:movies/core/services/movies_service.dart';
import 'package:movies/core/state_management/bloc_event.dart';
import 'package:movies/core/state_management/cubit_state.dart';
import 'package:movies/features/generic_widgets/sliver_search_app_bar.dart';
import 'package:movies/features/movies/cubit/events.dart';
import 'package:movies/features/movies/cubit/search_cubit.dart';
import 'package:movies/features/movies/data_sources/movies_local_data_source.dart';
import 'package:movies/features/movies/data_sources/movies_remote_data_source.dart';
import 'package:movies/features/movies/movies_repository.dart';
import 'package:movies/features/movies/widgets/movie_tile.dart';
import 'package:movies/features/repo_result.dart';

import '../../../core/ui_utils.dart';
import '../../../models/movie.dart';
import '../../generic_widgets/wait_widget.dart';
import 'movie_detail_screen.dart';

class MoviesListPage extends StatelessWidget {
  const MoviesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SearchCubit(
          MoviesRepository(
            MoviesRemoteDataSource(MoviesService()),
            MoviesLocalDataSource(
              KiwiContainer().resolve<NoSqlStorageContract>(),
            ),
          ),
        );
      },
      child: const MoviesListScreen(),
    );
  }
}

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, CubitState>(
      builder: (context, state) {
        final List<Movie> movies = [];
        if (state is CubitSuccessState) {
          movies.addAll(state.result);
        }
        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: NestedScrollView(
            headerSliverBuilder: (_, __) => [
              SliverSearchAppBar("Movies", (c, q) {
                if (q.isEmpty) {
                  cubit.add(LoadFavouritesEvent());
                }
              }, (c, q) {
                hideKeyboard(context);
                cubit.add(SearchEvent(q));
              }),
            ],
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: Scrollbar(
                child: CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    if (cubit.isSearchFieldEmpty)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Favourites:",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    if (state is CubitFailureState)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text((state.error is RepoError)
                              ? '${state.error.message}'
                              : "Something went wrong"),
                        ),
                      )
                    else if (state is CubitLoadingState)
                      const SliverToBoxAdapter(
                        child: WaitWidget(),
                      )
                    else
                      movies.isEmpty
                          ? SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 28.0),
                                child: Center(
                                  child: Text(cubit.isSearchFieldEmpty
                                      ? "No Favourites! Please search for movies to add to favourites"
                                      : "No Results found!"),
                                ),
                              ),
                            )
                          : SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio:
                                    (MediaQuery.of(context).size.width / 2) /
                                        160,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                childCount: movies.length,
                                (context, index) => MovieTile(
                                  onPressed: () async {
                                    hideKeyboard(context);
                                    await Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MovieDetailScreen(
                                        movie: movies[index],
                                        isFavourite: cubit.favourites
                                            .map((e) => e.title)
                                            .contains(movies[index].title),
                                      );
                                    }));
                                    if (cubit.isSearchFieldEmpty) {
                                      cubit.add(LoadFavouritesEvent());
                                    }
                                  },
                                  movie: movies[index],
                                ),
                              ),
                            ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  SearchCubit get cubit => context.read<SearchCubit>();
}
