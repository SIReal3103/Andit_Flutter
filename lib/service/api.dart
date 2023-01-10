import 'dart:convert';
import 'dart:io';

import '../models/login/api_error.dart';
import '../models/login/api_response.dart';
import '../models/login/user.dart';
import 'package:http/http.dart' as http;

String _baseUrl = "http://192.168.1.8:9001/";

Future<ApiResponse> authenticateUser(String username, String password) async {
  ApiResponse apiResponse = ApiResponse();

  var url = Uri.https('example.com', '${_baseUrl}user/login');
  try {
    final response = await http.post(url, body: {
      'username': username,
      'password': password,
    });
    switch (response.statusCode)  {
      case 200:
        apiResponse.data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    apiResponse.apiError = ApiError("Server error. Please retry");
  } on HttpException {
    apiResponse.apiError = ApiError("Couldn't find the post 😱");
  } on FormatException {
    apiResponse.apiError = ApiError("Bad response format 👎");
  }

  return apiResponse;
}
