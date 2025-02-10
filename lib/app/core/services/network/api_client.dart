import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fakestore/app/core/constants/api_constants.dart';
import 'package:fakestore/app/core/services/logger/app_logger.dart';
import 'package:http/http.dart' as http;

import 'api_base.dart';
import 'app_exceptions.dart';

class ApiClient extends ApiBase {
  // Generic GET Method --------------------------------
  @override
  Future<T> getRequest<T>({
    required String endpoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = buildUri(endpoint, queryParams: queryParams);
      // Log the response Url and Query Params
      log(level: LogLevel.info, 'Url: $uri\nQuery Params:\n $queryParams');

      final response = await http.get(uri, headers: await headers).timeout(ApiConstants.connectionTimeout);

      // Log the response status and body
      log(level: LogLevel.info, 'Url: $uri\nQuery Params:\n $queryParams\nStatus Code: ${response.statusCode}\nResponses:\n ${response.body}');

      return fromJson(await handleResponse(response));
    } on SocketException {
      log('No internet connection', level: LogLevel.error);
      throw NoInternetException();
    } on TimeoutException {
      log(level: LogLevel.error, 'Request timeout');
      throw RequestTimeoutException();
    } on FormatException {
      log('Invalid Format', level: LogLevel.error);
      throw FormatException();
    } catch (e) {
      log(e.toString(), level: LogLevel.error);
      rethrow;
    }
  }

  ///-- Generic GET Method --------------------------------
  @override
  Future<T> postRequest<T>({
    required String endpoint,
    required Map<String, dynamic> body,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = buildUri(endpoint, queryParams: queryParams);
      // Log the response Url and Query Params
      log(level: LogLevel.info, 'Url: $uri\nQuery Params:\n $queryParams');

      final response =
          await http.post(uri, body: jsonEncode(body), headers: await headers).timeout(ApiConstants.connectionTimeout);

      // Log the response status and body
      log(level: LogLevel.info, 'Status Code: ${response.statusCode}\nResponses:\n ${response.body}');

      return fromJson(await handleResponse(response));
    } on SocketException {
      log(level: LogLevel.error, 'No internet connection');
      throw NoInternetException();
    } on TimeoutException {
      log(level: LogLevel.error, 'Request timeout');
      throw RequestTimeoutException();
    } catch (e) {
      log(e.toString(), level: LogLevel.error);
      rethrow;
    }
  }
}
