class BushaAppException implements Exception {
  final String errorMessage;
  final dynamic stackTrace;
  final int? statusCode;

  BushaAppException(this.errorMessage, {this.stackTrace, this.statusCode});

  @override
  String toString() {
    return 'BushaAppException{errorMessage: $errorMessage, stackTrace: $stackTrace, statusCode: $statusCode}';
  }
}