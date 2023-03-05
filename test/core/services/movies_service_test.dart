/*
Tests Covered:
✓ test searchFor  Verify mockClient get is called
✓ test searchFor  Verify service get returns same response object that is returned from client
✓ test searchFor  Verify service throws error when client throws ServerException
*/
import 'package:flutter_test/flutter_test.dart';
import 'package:kiwi/kiwi.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/core/exceptions/server_exception.dart';
import 'package:movies/core/network/models/mresponse.dart';
import 'package:movies/core/network/network_client.dart';
import 'package:movies/core/services/movies_service.dart';

import 'movies_service_test.mocks.dart';

@GenerateMocks([NetworkClient])
void main() {
  MockNetworkClient client = MockNetworkClient();
  setUpAll(() {
    KiwiContainer().registerSingleton<NetworkClient>((container) => client);
  });

  group("test searchFor ", () {
    const searchTitle = "Star";
    const failureSearchTitle = "St";
    final successResponse = MResponse('');
    setUp(() {
      when(client.get('?s=$searchTitle', any))
          .thenAnswer((realInvo) async => successResponse);
      when(client.get('?s=$failureSearchTitle', any))
          .thenAnswer((realInvo) async => throw ServerException(400, ''));
    });

    test("Verify mockClient get is called", () async {
      await MoviesService().searchFor(searchTitle);
      verify(client.get('?s=$searchTitle', anything)).called(1);
    });

    test(
        "Verify service get returns same response object that is returned from client",
        () async {
      final actual = await MoviesService().searchFor(searchTitle);
      expect(actual, successResponse);
    });

    test("Verify service throws error when client throws ServerException",
        () async {
      expect(MoviesService().searchFor(failureSearchTitle),
          throwsA(isA<ServerException>()));
    });
  });

  // we can add similar tests for movie details api
}
