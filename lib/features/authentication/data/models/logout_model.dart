import 'package:equatable/equatable.dart';

class LogoutModel extends Equatable {
  final String? message;

  const LogoutModel({this.message});

  factory LogoutModel.fromJson(Map<String, dynamic> json) =>
      LogoutModel(message: json['message'] as String?);

  Map<String, dynamic> toJson() => {'message': message};

  @override
  List<Object?> get props => [message];
}
