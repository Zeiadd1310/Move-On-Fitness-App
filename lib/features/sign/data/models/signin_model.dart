import 'package:equatable/equatable.dart';

class SigninModel extends Equatable {
  final String? token;

  const SigninModel({this.token});

  factory SigninModel.fromJson(Map<String, dynamic> json) =>
      SigninModel(token: json['token'] as String?);

  Map<String, dynamic> toJson() => {'token': token};

  @override
  List<Object?> get props => [token];
}
