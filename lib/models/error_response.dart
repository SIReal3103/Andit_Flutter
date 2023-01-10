class ErrorResponse {
  ErrorResponse({
    this.statusCode,
    this.path,
    // this.details,
    this.description,
    this.message,
    this.response,
  });

  final int? statusCode;
  final String? path;
  // final List<dynamic>? details;
  final String? description;
  final String? message;
  final String? response;

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (statusCode != null) {
      result.addAll({'statusCode': statusCode});
    }
    if (path != null) {
      result.addAll({'path': path});
    }
    // if (details != null) {
    //   result.addAll({'details': details});
    // }
    if (description != null) {
      result.addAll({'description': description});
    }
    result.addAll({'message': message});
    if (response != null) {
      result.addAll({'response': response});
    }

    return result;
  }

  factory ErrorResponse.fromJson(Map<String, dynamic>? map) {
    return ErrorResponse(
      statusCode: map?['statusCode']?.toInt(),
      path: map?['path'],
      // details: List<dynamic>.from(map?['details']),
      description: map?['description'],
      message: map?['message'],
      response: map?['response'],
    );
  }
}
