import 'package:movies/core/network/models/mresponse.dart';

/// A contract class that defines how a network client should look like.
/// So that in future even if the actual client we are using is changed
/// the dependencies of that client and related test cases will not get affected
abstract class NetworkClient {
  Future<MResponse> get(String path, dynamic body);
  Future<MResponse> post(String path, dynamic body);
}
