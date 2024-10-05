import 'dart:convert';

class ErrorResponse {
  ErrorResponse({
    this.error,
    this.errorDescription,
    this.message,
    this.title,
    this.description,
    this.code,
    this.http_code,
  });

  String? error;
  String? errorDescription;
  String? message;
  String? title;
  String? description;
  String? code;
  int? http_code;

  ErrorResponse copyWith({
    String? error,
    String? errorDescription,
    String? message,
    String? title,
    String? description,
    String? code,
    int? http_code,
  }) =>
      ErrorResponse(
        error: error ?? this.error,
        errorDescription: errorDescription ?? this.errorDescription,
        message: message ?? this.message,
        title: title ?? this.title,
        description: description ?? this.description,
        code: code ?? this.code,
        http_code: http_code ?? this.http_code,
      );

  factory ErrorResponse.fromRawJson(String str) =>
      ErrorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        error: json["error"] == null ? null : json["error"].toString(),
        errorDescription: json["error_description"] == null
            ? null
            : json["error_description"],
        message: json["message"] == null ? null : json["message"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        code: json["code"] == null ? null : json["code"],
        http_code: json["http_code"] == null ? null : json["http_code"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "error_description": errorDescription == null ? null : errorDescription,
        "message": message == null ? null : message,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "code": code == null ? null : code,
        "http_code": http_code == null ? null : http_code,
      };
}
