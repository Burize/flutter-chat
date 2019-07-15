class ApiError extends HandleableException {
  ApiError({int statusCode, String message})
      : super('ApiError: {status: $statusCode, message: $message}');
}

class HandleableException implements Exception {
  final String msg;
  HandleableException([this.msg]);
}
