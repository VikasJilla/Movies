import 'package:movies/core/network/models/mresponse.dart';

import '../../inject/dependency_resolver.dart';
import '../network/network_client.dart';

class MoviesService {
  Future<MResponse> searchFor(String title) async {
    //we will get dioClient implementation but it can be anything in future
    final client = DependencyResolver().getType<NetworkClient>();
    return await client.get('?s=$title', null);
  }

  Future<MResponse> movieDetails(String title) async {
    //we will get dioClient implementation but it can be anything in future
    final client = DependencyResolver().getType<NetworkClient>();
    return await client.get('?t=$title', null);
  }
}
