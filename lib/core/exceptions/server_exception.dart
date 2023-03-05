class ServerException extends Error {
  final int? statusCode;
  final dynamic body;

  ServerException(this.statusCode, this.body);
}
