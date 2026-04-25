import 'package:equatable/equatable.dart';

class ProfilePictureModel extends Equatable {
  final String? profilePictureUrl;

  const ProfilePictureModel({this.profilePictureUrl});

  factory ProfilePictureModel.fromJson(Map<String, dynamic> json) {
    final source = (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : json;

    String? readString(List<String> keys) {
      for (final key in keys) {
        final value = source[key];
        if (value == null) continue;
        final text = value.toString().trim();
        if (text.isNotEmpty) return text;
      }
      return null;
    }

    return ProfilePictureModel(
      profilePictureUrl: readString([
        'profilePictureUrl',
        'profileImageUrl',
        'imageUrl',
        'url',
      ]),
    );
  }

  Map<String, dynamic> toJson() => {'profilePictureUrl': profilePictureUrl};

  @override
  List<Object?> get props => [profilePictureUrl];
}
