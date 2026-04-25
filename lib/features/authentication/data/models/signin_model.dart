import 'package:equatable/equatable.dart';

class SigninModel extends Equatable {
  final String? token;

  const SigninModel({this.token});

  factory SigninModel.fromJson(Map<String, dynamic> json) {
    String? readToken(Map<String, dynamic> source) {
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
      final text = value?.toString().trim() ?? '';
      return text.isEmpty ? null : text;
    }

    final direct = readToken(json);
    if (direct != null) return SigninModel(token: direct);

    final data = json['data'];
    if (data is Map<String, dynamic>) {
      final nested = readToken(data);
      if (nested != null) return SigninModel(token: nested);
    }

    return const SigninModel(token: null);
  }

  Map<String, dynamic> toJson() => {'token': token};

  @override
  List<Object?> get props => [token];
}
