// Low Level Module -- belongs to data layer (raw error)
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, [this.statusCode]);

  @override
  String toString() {
    return 'ServerException: $message (code: ${statusCode ?? "N/A"})';
  }
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}
