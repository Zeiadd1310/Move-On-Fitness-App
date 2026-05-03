/// Lightweight profile hints from Google / Facebook SDKs before or after backend auth.
/// Not all fields exist on both providers (e.g. birthday is uncommon on Google Sign-In).
class OAuthAccountSnapshot {
  OAuthAccountSnapshot({
    required this.displayName,
    required this.email,
    required this.photoUrl,
    this.dateOfBirthIso,
    this.gender = '',
  });

  final String displayName;
  final String email;
  final String photoUrl;

  /// Normalized [yyyy-MM-dd] when the provider exposes a full birthday (e.g. Facebook).
  final String? dateOfBirthIso;

  /// For body-data pending merge: `Male` or `Femail` (matches the body-data selector).
  final String gender;

  bool get hasAnyData =>
      displayName.trim().isNotEmpty ||
      email.trim().isNotEmpty ||
      photoUrl.trim().isNotEmpty ||
      gender.trim().isNotEmpty ||
      (dateOfBirthIso != null && dateOfBirthIso!.trim().isNotEmpty);

  /// Meta Graph often returns `male` / `female`.
  static String normalizeFacebookGender(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '';
    switch (raw.trim().toLowerCase()) {
      case 'male':
        return 'Male';
      case 'female':
      case 'femail':
        return 'Femail';
      default:
        return '';
    }
  }

  /// Facebook often returns MM/DD/YYYY; Google People API-style ISO also accepted.
  static String? normalizeBirthdayToIso8601Date(String? raw) {
    if (raw == null) return null;
    final t = raw.trim();
    if (t.isEmpty) return null;

    final isoTry = DateTime.tryParse(t);
    if (isoTry != null) {
      return _formatYmd(isoTry);
    }

    final mdyFull = RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4})$');
    final m = mdyFull.firstMatch(t);
    if (m != null) {
      final mm = int.tryParse(m.group(1)!);
      final dd = int.tryParse(m.group(2)!);
      final yyyy = int.tryParse(m.group(3)!);
      if (mm == null || dd == null || yyyy == null) return null;
      final dt = DateTime(yyyy, mm, dd);
      if (dt.year == yyyy && dt.month == mm && dt.day == dd) {
        return _formatYmd(dt);
      }
    }
    return null;
  }

  static String _formatYmd(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  /// Age in full years from [dateOfBirthIso], or null if invalid.
  static int? computeAgeYears(String? isoYmd) {
    if (isoYmd == null || isoYmd.trim().isEmpty) return null;
    final dob = DateTime.tryParse(isoYmd.trim());
    if (dob == null) return null;

    final now = DateTime.now();
    var age = now.year - dob.year;
    final hadBirthday = (now.month > dob.month) ||
        (now.month == dob.month && now.day >= dob.day);
    if (!hadBirthday) age -= 1;
    if (age < 0 || age > 130) return null;
    return age;
  }
}
