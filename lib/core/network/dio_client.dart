import 'package:dio/dio.dart';
import 'package:movies/core/constants/string_constants.dart';
import 'package:movies/core/logger.dart';
import 'package:movies/core/network/models/mresponse.dart';
import 'package:movies/core/network/network_client.dart';

import '../exceptions/server_exception.dart';
import 'configuration.dart';

class DioClient implements NetworkClient {
  late final Dio dio;

  DioClient() {
    const timeOutDuration = Duration(seconds: 60 * 1000);
    final options = BaseOptions(
      baseUrl: Configuration.instance.baseUrl,
      sendTimeout: timeOutDuration,
      connectTimeout: timeOutDuration,
      receiveTimeout: timeOutDuration,
    );
    dio = Dio(options);
    //add interceptors
    //we can add custom interceptors for handling unauthorized errors and
    //preemptively refresh the access token without having to logout the user
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      logPrint: logger.i,
    ));
  }

  @override
  Future<MResponse> get(String path, body) async {
    final response = await dio.get(
      path,
      data: body,
      queryParameters: {StringConstants.apiKey: Configuration.instance.apiKey},
    );
    if (response.statusCode == 200) {
      return MResponse(response.data);
    } else {
      // Along with throwing error we can also put custom error logging tools and log the error
      throw ServerException(response.statusCode, response.data);
    }
  }

  @override
  Future<MResponse> post(String path, body) async {
    final response = await dio.post(
      path,
      data: body,
      queryParameters: {StringConstants.apiKey: Configuration.instance.apiKey},
    );
    if (response.statusCode == 200) {
      return MResponse(response.data);
    } else {
      // Along with throwing error we can also put custom error logging tools and log the error
      throw ServerException(response.statusCode, response.data);
    }
  }
}
