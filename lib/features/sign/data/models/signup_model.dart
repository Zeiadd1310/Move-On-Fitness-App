import 'package:equatable/equatable.dart';

class SignupModel extends Equatable {
  final String token;

  const SignupModel({required this.token});

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      SignupModel(token: json['token'] as String);

  Map<String, dynamic> toJson() => {'token': token};

  @override
  List<Object?> get props => [token];
}
