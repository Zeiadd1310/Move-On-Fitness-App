import 'package:equatable/equatable.dart';

class ForgotPasswordModel extends Equatable {
  final String? message;

  const ForgotPasswordModel({this.message});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'message': message};

  @override
  List<Object?> get props => [message];
}
