import 'dart:convert';

/// Extracts a stable user key from a JWT payload (no signature verification).
/// Used only for local onboarding / navigation, not for security decisions.
class JwtSubjectReader {
  JwtSubjectReader._();

  static const _claimPriority = [
    'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier',
    'sub',
    'nameid',
    'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress',
    'email',
  ];

  static Map<String, dynamic>? _decodePayload(String jwt) {
    try {
      final parts = jwt.split('.');
      if (parts.length < 2) return null;
      var payload = parts[1];
      while (payload.length % 4 != 0) {
        payload += '=';
      }
      final decoded = utf8.decode(base64Url.decode(payload));
      final map = jsonDecode(decoded);
      if (map is! Map<String, dynamic>) return null;
      return map;
    } catch (_) {
      return null;
    }
  }

  /// All stable identifiers present in this token for account matching.
  /// Email-style claims are lowercased; other claims normalized to lowercase
  /// so the same ASP.NET Identity user stays matched across login methods.
  static Set<String> readComparableAccountKeys(String jwt) {
    final map = _decodePayload(jwt);
    if (map == null) return {};

    final out = <String>{};
    for (final k in _claimPriority) {
      final v = map[k];
      final s = v?.toString().trim();
      if (s == null || s.isEmpty) continue;

      out.add(s.toLowerCase());
    }
    return out;
  }

  static String? readSubject(String jwt) {
    try {
      final map = _decodePayload(jwt);
      if (map == null) return null;

      for (final k in _claimPriority) {
        final v = map[k];
        if (v != null && v.toString().trim().isNotEmpty) {
          return v.toString();
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
