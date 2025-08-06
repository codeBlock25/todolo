class ErrorResponse {
  String? message;
  Map<String, dynamic>? errors;

  ErrorResponse({this.message, this.errors});

  ErrorResponse copyWith({
    String? message,
    Map<String,  dynamic>? errors,
  }) => ErrorResponse(
    message: message ?? this.message,
    errors: errors ?? this.errors,
  );

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {"message": message, "errors": errors};
}
