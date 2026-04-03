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
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      dynamic message;

      try {
        message = response?['error']?['message'] ?? response?['message'];

        // Handle common validation/error shapes for the `errors` field safely
        if (message == null && response?['errors'] != null) {
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

      message ??= 'Something went wrong, please try again';
      return ServerFailure(message.toString());
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, please try again later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, please try later');
    } else {
      return ServerFailure('Oops, there was an error, please try again');
    }
  }
}
