class Failure implements Exception {
  Failure(this.message, this.stackTrace);

  final String message;
  final StackTrace stackTrace;
}
