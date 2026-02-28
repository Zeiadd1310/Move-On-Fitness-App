import 'package:dio/dio.dart';

class ApiService {
  static const String _baseUrl = 'http://moveonapi-2-1.runasp.net/api/';

  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: _baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {'Content-Type': 'application/json'},
          ),
        );

  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? token,
  }) async {
    final response = await _dio.get(
      endPoint,
      options: _buildOptions(token),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    final response = await _dio.post(
      endPoint,
      data: body,
      options: _buildOptions(token),
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
    final response = await _dio.delete(
      endPoint,
      options: _buildOptions(token),
    );
    return response.data;
  }

  Options _buildOptions(String? token) {
    return Options(
      headers: token != null ? {'Authorization': 'Bearer $token'} : null,
    );
  }
}
