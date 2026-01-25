import 'dart:convert';
import 'package:ecommerce_assignment_module_31/core/models/network_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller {
  static final Logger _logger = Logger();

  final VoidCallback onUnauthorized;
  final Map<String, String>? headers;

  NetworkCaller({required this.onUnauthorized, required this.headers});

  Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url);
      Response response = await get(uri, headers: headers);
      _logResponse(url, response);

      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        // SUCCESS
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          responseCode: statusCode,
          responseData: decodedData,
        );
      } else if (statusCode == 401) {
        onUnauthorized();
        return NetworkResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: null,
          errorMessage: "Unauthorized",
        );
      } else {
        // FAILED
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedData,
          errorMessage: decodedData['data'],
        );
      }
    } on Exception catch (e) {
      return NetworkResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, body: body);
      Response response = await post(
        uri,
        headers: headers ?? {'content-type': 'application/json'},
        body: jsonEncode(body),
      );
      _logResponse(url, response);

      final int statusCode = response.statusCode;

      if (statusCode == 200 || statusCode == 201) {
        // SUCCESS
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          responseCode: statusCode,
          responseData: decodedData,
        );
      } else if (statusCode == 401) {
        onUnauthorized();
        return NetworkResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: null,
          errorMessage: "Unauthorized",
        );
      } else {
        // FAILED
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedData,
          errorMessage: decodedData['msg'],
        );
      }
    } on Exception catch (e) {
      return NetworkResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i(
      'URL => $url\n'
      'Request Body: $body',
    );
  }

  void _logResponse(String url, Response response) {
    _logger.i(
      'URL => $url\n'
      'Status Code: ${response.statusCode}\n'
      'Body: ${response.body}',
    );
  }

  Future<void> _moveToLogin() async {
    // await AuthController.clearUserData();
    // Navigator.pushNamedAndRemoveUntil(
    //   TaskManager.navigator.currentContext!,
    //   LoginScreen.name,
    //   (predicate) => false,
    // );
  }
}
