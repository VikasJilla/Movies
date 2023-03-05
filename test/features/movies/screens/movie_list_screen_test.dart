/*
✓ test if movie tile is displayed
*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/core/state_management/cubit_state.dart';
import 'package:movies/features/movies/cubit/search_cubit.dart';
import 'package:movies/features/movies/screens/movies_list_screen.dart';
import 'package:movies/features/movies/widgets/movie_tile.dart';
import 'package:movies/models/movie.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'movie_list_screen_test.mocks.dart';

@GenerateMocks([SearchCubit])
void main() {
  final SearchCubit cubit = MockSearchCubit();

  Widget getMaterialApp() {
    return BlocProvider.value(
      value: cubit,
      child: const MaterialApp(
        home: MoviesListScreen(),
      ),
    );
  }

  testWidgets("test if movie tile is displayed", (tester) async {
    when(cubit.state).thenReturn(CubitSuccessState(
        [Movie("hello", '2021', 'http://via.placeholder.com/350x150')]));
    when(cubit.stream).thenAnswer((_) => Stream.fromIterable([
          CubitSuccessState(
              [Movie("hello", '2021', 'http://via.placeholder.com/350x150')])
        ]));
    when(cubit.isSearchFieldEmpty).thenReturn(false);
    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(getMaterialApp()));

    await tester.pumpAndSettle();
    expect(find.byType(MovieTile), findsOneWidget);
  });
}
