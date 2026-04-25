import 'package:equatable/equatable.dart';

class SignupModel extends Equatable {
  final String token;

  const SignupModel({required this.token});

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    String readToken(Map<String, dynamic> source) {
      final normalized = <String, dynamic>{};
      source.forEach((key, value) {
        normalized[key.toString().toLowerCase()] = value;
      });
      final value =
          source['token'] ??
          source['accessToken'] ??
          source['access_token'] ??
          normalized['token'] ??
          normalized['accesstoken'] ??
          normalized['access_token'];
      return value?.toString().trim() ?? '';
    }

    final direct = readToken(json);
    if (direct.isNotEmpty) return SignupModel(token: direct);

    final data = json['data'];
    if (data is Map<String, dynamic>) {
      final nested = readToken(data);
      if (nested.isNotEmpty) return SignupModel(token: nested);
    }

    return const SignupModel(token: '');
  }

  Map<String, dynamic> toJson() => {'token': token};

  @override
  List<Object?> get props => [token];
}
