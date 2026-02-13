import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:practice_test/core/error/exceptions.dart';
import 'package:practice_test/core/network/api_constants.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiClient {
  final String baseUrl;
  final String apiKey;

  ApiClient() : baseUrl = ApiConstants.baseUrl, apiKey = ApiConstants.apiKey;

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(
        baseUrl + path,
      ).replace(queryParameters: queryParameters);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw UnauthorizedException('Invalid API key or unauthorized access');
      } else if (response.statusCode == 404) {
        throw ServerException('Resource not found: $path');
      } else if (response.statusCode >= 500) {
        throw ServerException('Server error: ${response.statusCode}');
      } else {
        throw ServerException(
          'Failed to fetch data: ${response.statusCode} - ${response.body}',
        );
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }
}
