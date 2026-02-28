import 'package:equatable/equatable.dart';

class ResendOtpModel extends Equatable {
  final String? message;

  const ResendOtpModel({this.message});

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) {
    return ResendOtpModel(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'message': message};

  @override
  List<Object?> get props => [message];
}
