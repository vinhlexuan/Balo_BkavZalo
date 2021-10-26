class APIException implements Exception {
  final String code;
  final String message;

  APIException({
    required this.code,
    required this.message,
  });

  factory APIException.fromJson(Map<String, dynamic> json) {
    return APIException(
      code: json['code'],
      message: json['message'],
    );
  }
}
