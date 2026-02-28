import 'package:equatable/equatable.dart';

class ForgotPasswordModel extends Equatable {
  final String? message;
  final String? token;

  const ForgotPasswordModel({this.message, this.token});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      message: json['message'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'message': message, 'token': token};

  @override
  List<Object?> get props => [message, token];
}
