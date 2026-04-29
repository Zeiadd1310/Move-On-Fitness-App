import 'dart:developer';

import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure('Unexpected Error, Please try again later!');
      case DioExceptionType.badCertificate:
        return ServerFailure(
          'SSL Certificate Error: The server\'s certificate is invalid or untrusted. Please check your connection or contact support.',
        );
      //   default:
      //     return ServerFailure('Oops, there was an error, please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    // Some backends return a plain string body on errors (or even HTML).
    // Handle those cases first to avoid `[]`/`{}` shape assumptions.
    if (response is String) {
      final trimmed = response.trim();
      if (trimmed.isNotEmpty) {
        if (statusCode == 401) {
          return ServerFailure('Unauthorized. Please sign in again.');
        }
        if (statusCode == 403) {
          return ServerFailure('Access denied. Please sign in again.');
        }
        return ServerFailure(trimmed);
      }
    }

    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      dynamic message;
      log('🔴 RAW RESPONSE [$statusCode]: $response');
      try {
        if (response is Map) {
          message = response['error']?['message'] ?? response['message'];
          // Common alternative keys
          message ??= response['title'] ?? response['detail'];
        }

        // Handle common validation/error shapes for the `errors` field safely
        if (message == null && response is Map && response['errors'] != null) {
          final errors = response['errors'];

          if (errors is List && errors.isNotEmpty) {
            // e.g. ["Email is required", "Password is required"]
            message = errors.first;
          } else if (errors is Map && errors.isNotEmpty) {
            // e.g. { "Email": ["Email is required"] }
            final firstKey = errors.keys.first;
            final value = errors[firstKey];
            if (value is List && value.isNotEmpty) {
              message = value.first;
            } else if (value != null) {
              message = value.toString();
            }
          }
        }
      } catch (_) {
        // Fallback to generic message if parsing fails for any reason
        message = null;
      }

      if (message == null) {
        if (statusCode == 401) {
          message = 'Unauthorized. Please sign in again.';
        } else if (statusCode == 403) {
          message = 'Access denied. Please sign in again.';
        } else {
          message = 'Something went wrong, please try again';
        }
      }
      return ServerFailure(message.toString());
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, please try again later!');
    } else if (statusCode == 500) {
      dynamic message;
      try {
        if (response is Map) {
          message =
              response['error']?['message'] ??
              response['message'] ??
              response['title'] ??
              response['detail'];
        } else if (response is String) {
          message = response.trim();
        }

        if (message == null && response is Map && response['errors'] != null) {
          final errors = response['errors'];
          if (errors is Map && errors.isNotEmpty) {
            final firstKey = errors.keys.first;
            final value = errors[firstKey];
            if (value is List && value.isNotEmpty) {
              message = value.first;
            } else if (value != null) {
              message = value.toString();
            }
          }
        }
      } catch (_) {
        message = null;
      }
      return ServerFailure(
        (message?.toString().trim().isNotEmpty ?? false)
            ? message.toString()
            : 'Internal Server error, please try later',
      );
    } else {
      return ServerFailure('Oops, there was an error, please try again');
    }
  }
}
