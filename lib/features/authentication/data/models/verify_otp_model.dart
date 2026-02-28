import 'package:equatable/equatable.dart';

class VerifyOtpModel extends Equatable {
  final String? message;

  const VerifyOtpModel({this.message});

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'message': message};

  @override
  List<Object?> get props => [message];
}
