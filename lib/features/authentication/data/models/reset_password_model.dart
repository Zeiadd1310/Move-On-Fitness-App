import 'package:equatable/equatable.dart';

class ResetPasswordModel extends Equatable {
  final String? message;

  const ResetPasswordModel({this.message});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'message': message};

  @override
  List<Object?> get props => [message];
}
