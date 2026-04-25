import 'package:equatable/equatable.dart';

class EditProfileModel extends Equatable {
  final String? message;

  const EditProfileModel({this.message});

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'message': message};

  @override
  List<Object?> get props => [message];
}
