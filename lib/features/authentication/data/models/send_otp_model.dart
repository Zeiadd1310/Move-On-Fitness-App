import 'package:equatable/equatable.dart';

class SendOtpModel extends Equatable {
  final String? message;

  const SendOtpModel({this.message});

  factory SendOtpModel.fromJson(Map<String, dynamic> json) =>
      SendOtpModel(message: json['message'] as String?);

  Map<String, dynamic> toJson() => {'message': message};

  @override
  List<Object?> get props => [message];
}
