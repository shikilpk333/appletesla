class ServerException implements Exception {
  final String message;
  ServerException([this.message = "Server exception"]);
  @override
  String toString() => message;
}
