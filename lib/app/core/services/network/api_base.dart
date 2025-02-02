import 'dart:convert';
import 'package:fakestore/app/core/services/secure_storage/secure_storage.dart';
import 'package:fakestore/app/utils/logger/app_logger.dart';
import 'package:fakestore/app/core/services/network/response/api_response.dart';
import 'package:http/http.dart' as http;

import 'app_exceptions.dart';


abstract class ApiBase with AppLogger {
  final SecureStorage _storage = SecureStorage();

  // Prepare headers for requests
  Future<Map<String, String>> get headers async {
    final String token = await _storage.read(key: SSKey.token);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (token.isNotEmpty) {
      headers['token'] = token;
    }
    return headers;
  }

  // Build URI with optional query parameters
  Uri buildUri(String endpoint, {Map<String, dynamic>? queryParams}) {
    Uri uri = Uri.parse(endpoint);
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }
    return uri;
  }



  Future<T> getRequest<T>({
    required String endpoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? queryParams,
  });

  Future<T> postRequest<T>({
    required String endpoint,
    required Map<String, dynamic> body,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? queryParams,
  });

  ///-- Method to handle HTTP responses
  dynamic handleResponse(http.Response response) {
    final ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if ((response.statusCode == 200 || response.statusCode == 201) && apiResponse.msg == 'success') {
      return apiResponse.data;
    }
    throw _handleHttpException(response);
  }

  ///-- Private method to handle all HTTP Exception
  dynamic _handleHttpException(http.Response response) {
    final int statusCode = response.statusCode;
    switch (statusCode) {
      case 400:
        throw FetchDataException(message: 'Bad request. Please try again.', code: statusCode);
      case 401:
        throw FetchDataException(message: 'Unauthorized access. Please check your credentials.', code: statusCode);
      case 403:
        throw FetchDataException(message: 'Forbidden access.', code: statusCode);
      case 404:
        throw FetchDataException(message: 'Resource not found. Please check the URL.', code: statusCode);
      case 500:
        throw FetchDataException(message: 'Internal server error. Please try again later.', code: statusCode);
      case 503:
        throw FetchDataException(message: 'Service unavailable. Please try again later.', code: statusCode);
      default:
        throw FetchDataException(message: 'Something went wrong. Please try again.', code: statusCode);
    }
  }
}
