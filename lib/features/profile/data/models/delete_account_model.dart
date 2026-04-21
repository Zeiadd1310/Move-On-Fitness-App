import 'package:equatable/equatable.dart';

class DeleteAccountModel extends Equatable {
  final String? message;

  const DeleteAccountModel({this.message});

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) {
    return DeleteAccountModel(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'message': message};

  @override
  List<Object?> get props => [message];
}
