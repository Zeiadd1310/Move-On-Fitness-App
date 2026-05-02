import 'package:equatable/equatable.dart';

class ChangePasswordModel extends Equatable {
  final String? message;

  const ChangePasswordModel({this.message});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'message': message};

  @override
  List<Object?> get props => [message];
}
