import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:move_on/core/models/oauth_account_snapshot.dart';

class SocialAuthService {
  SocialAuthService({GoogleSignIn? googleSignIn})
    : _googleSignIn =
          googleSignIn ??
          GoogleSignIn(
            scopes: const ['email', 'openid', 'profile'],
            serverClientId: _googleWebClientId.isEmpty
                ? null
                : _googleWebClientId,
          );

  static const String _googleWebClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
    defaultValue: '',
  );

  final GoogleSignIn _googleSignIn;

  /// Returns Google [idToken] for your API plus basic profile shown in Gmail / account picker.
  /// Age is not exposed by basic Google Sign-In; users enter it manually or rely on Facebook DOB when available.
  Future<({String idToken, OAuthAccountSnapshot profile})?>
  completeGoogleSignInForBackend() async {
    if (kIsWeb) {
      throw UnsupportedError(
        'Google Sign-In on web requires extra configuration.',
      );
    }
    if (defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS) {
      throw UnsupportedError(
        'Google sign-in works on Android or iOS only. '
        'Windows/macOS desktop builds do not load this plugin — use an emulator or phone.',
      );
    }

    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return null;
      final auth = await account.authentication;
      final id = auth.idToken?.trim();
      if (id == null || id.isEmpty) {
        throw StateError(
          'No ID token from Google. Add --dart-define=GOOGLE_WEB_CLIENT_ID='
          '<your Web OAuth client ID from Google Cloud Console>.',
        );
      }
      final profile = OAuthAccountSnapshot(
        displayName: (account.displayName ?? '').trim(),
        email: account.email.trim(),
        photoUrl: (account.photoUrl ?? '').trim(),
        gender: '',
      );
      return (idToken: id, profile: profile);
    } on PlatformException catch (e) {
      final msg = e.message ?? '';
      if (msg.contains('12501') ||
          e.code == 'sign_in_canceled' ||
          msg.contains('SIGN_IN_CANCELLED')) {
        return null;
      }
      throw StateError(_formatGooglePlatformError(e));
    } on MissingPluginException catch (e) {
      throw StateError(_missingPluginHint(e.message));
    }
  }

  /// Requests `user_birthday` and `user_gender` in addition to defaults; both must
  /// be added and approved for your Meta app or login will show “Invalid Scopes”.
  Future<({String accessToken, OAuthAccountSnapshot profile})?>
  completeFacebookSignInForBackend() async {
    if (kIsWeb) {
      throw UnsupportedError(
        'Facebook Sign-In on web requires separate configuration.',
      );
    }
    if (defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS) {
      throw UnsupportedError(
        'Facebook login works on Android or iOS only. '
        'Windows/macOS desktop builds do not load this plugin — use an emulator or phone.',
      );
    }

    try {
      final result = await FacebookAuth.instance.login(
        permissions: const [
          'public_profile',
          'email',
          'user_birthday',
          'user_gender',
        ],
      );

      if (result.status == LoginStatus.cancelled) return null;
      if (result.status != LoginStatus.success) {
        throw StateError(result.message ?? 'Facebook login failed.');
      }
      final at = result.accessToken;
      if (at == null) return null;
      final value = at.tokenString.trim();
      if (value.isEmpty) {
        throw StateError('Facebook returned an empty access token.');
      }

      Map<String, dynamic>? userMap;
      try {
        userMap = await FacebookAuth.instance.getUserData(
          fields: 'name,email,picture.width(512).height(512),birthday,gender',
        );
      } catch (_) {
        userMap = null;
      }

      var profile = _oauthSnapshotFromFacebookMap(userMap);

      // flutter_facebook_auth often omits `email` in getUserData while returning
      // name/picture — stale Gmail then stays in local cache. Graph `/me` is reliable.
      if (profile.email.trim().isEmpty) {
        final graphEmail = await _fetchFacebookEmailFromGraphApi(value);
        if (graphEmail.isNotEmpty) {
          profile = OAuthAccountSnapshot(
            displayName: profile.displayName,
            email: graphEmail,
            photoUrl: profile.photoUrl,
            dateOfBirthIso: profile.dateOfBirthIso,
            gender: profile.gender,
          );
        }
      }

      return (accessToken: value, profile: profile);
    } on MissingPluginException catch (e) {
      throw StateError(_missingPluginHint(e.message));
    }
  }

  static Future<String> _fetchFacebookEmailFromGraphApi(
    String accessToken,
  ) async {
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 12),
          receiveTimeout: const Duration(seconds: 12),
          validateStatus: (s) => s != null && s < 500,
        ),
      );
      final res = await dio.get<Map<String, dynamic>>(
        'https://graph.facebook.com/v21.0/me',
        queryParameters: <String, dynamic>{
          'fields': 'email,name',
          'access_token': accessToken,
        },
      );
      final body = res.data;
      if (body == null) return '';
      final raw = body['email'];
      final e = raw?.toString().trim();
      return (e != null && e.isNotEmpty) ? e : '';
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('Facebook Graph /me email fetch failed: $e\n$st');
      }
      return '';
    }
  }

  static String _readFacebookEmail(Map<String, dynamic>? data) {
    if (data == null) return '';
    for (final entry in data.entries) {
      if (entry.key.toLowerCase() == 'email') {
        final v = entry.value?.toString().trim();
        if (v != null && v.isNotEmpty) return v;
      }
    }
    final user = data['user'];
    if (user is Map<String, dynamic>) {
      return _readFacebookEmail(user);
    }
    return '';
  }

  static OAuthAccountSnapshot _oauthSnapshotFromFacebookMap(
    Map<String, dynamic>? data,
  ) {
    String read(String k) =>
        data == null ? '' : data[k]?.toString().trim() ?? '';

    final fbEmail = _readFacebookEmail(data);

    final birthdayIso = OAuthAccountSnapshot.normalizeBirthdayToIso8601Date(
      read('birthday'),
    );
    final pictureRaw = data?['picture'];
    final picUrl = _facebookPictureUrl(pictureRaw);

    final genderMapped = OAuthAccountSnapshot.normalizeFacebookGender(
      read('gender'),
    );

    return OAuthAccountSnapshot(
      displayName: read('name'),
      email: fbEmail,
      photoUrl: picUrl,
      dateOfBirthIso: birthdayIso,
      gender: genderMapped,
    );
  }

  static String _facebookPictureUrl(dynamic pictureField) {
    if (pictureField is Map<String, dynamic>) {
      final data = pictureField['data'];
      if (data is Map<String, dynamic>) {
        final u = data['url']?.toString().trim();
        if (u != null && u.isNotEmpty) return u;
      }
    }
    return '';
  }

  static String _missingPluginHint(String? detail) {
    return 'Facebook native plugin missing. Use Android/iOS (not Windows desktop), '
        'then: flutter clean && flutter pub get && flutter run. '
        'Set real facebook_app_id & facebook_client_token in android/app/src/main/res/values/strings.xml. '
        '${detail ?? ''}';
  }

  static String _formatGooglePlatformError(PlatformException e) {
    final msg = e.message ?? '';
    final buf = StringBuffer('Google Sign-In failed');

    if (msg.contains('10') || msg.contains('DEVELOPER_ERROR')) {
      buf.write(
        ': Firebase/Google Cloud setup.\n'
        '• Firebase Console → Project settings → Your Android app → '
        'add SHA-1 (debug keystore), download google-services.json → android/app/\n'
        '• Rebuild with --dart-define=GOOGLE_WEB_CLIENT_ID=<Web client ID>\n',
      );
    } else {
      buf.write(': ');
    }
    buf.write(msg.isNotEmpty ? msg : (e.code));
    return buf.toString();
  }
}
