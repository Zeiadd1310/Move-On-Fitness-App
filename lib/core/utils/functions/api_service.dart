import 'package:dio/dio.dart';

class ApiService {
  static const String _baseUrl = 'http://moveonapi-2-1.runasp.net/api/';

  final Dio _dio;

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? token,
  }) async {
    final response = await _dio.get(endPoint, options: _buildOptions(token));
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> body,
    String? token,
    Duration? receiveTimeout,
  }) async {
    final response = await _dio.post(
      endPoint,
      data: body,
      options: _buildOptions(token, receiveTimeout: receiveTimeout),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> postFormData({
    required String endPoint,
    required FormData body,
    String? token,
  }) async {
    final response = await _dio.post(
      endPoint,
      data: body,
      options: _buildOptions(token, contentType: 'multipart/form-data'),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    final response = await _dio.put(
      endPoint,
      data: body,
      options: _buildOptions(token),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    String? token,
  }) async {
    final response = await _dio.delete(endPoint, options: _buildOptions(token));
    return response.data;
  }

  Options _buildOptions(
    String? token, {
    String contentType = 'application/json',
    Duration? receiveTimeout,
  }) {
    final sanitizedToken = token?.trim();
    return Options(
      receiveTimeout: receiveTimeout,
      headers: {
        'Content-Type': contentType,
        if (sanitizedToken != null && sanitizedToken.isNotEmpty)
          'Authorization': 'Bearer $sanitizedToken',
      },
    );
  }
}
