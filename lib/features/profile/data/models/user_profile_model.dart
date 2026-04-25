class UserProfileModel {
  final String fullName;
  final String email;
  final String dateOfBirth;
  final String mobileNumber;
  final String weight;
  final String height;
  final String profilePictureUrl;
  final String gender;

  const UserProfileModel({
    required this.fullName,
    required this.email,
    required this.dateOfBirth,
    required this.mobileNumber,
    required this.weight,
    required this.height,
    this.profilePictureUrl = '',
    this.gender = '',
  });

  String get firstName {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) return '';
    return trimmed.split(RegExp(r'\s+')).first;
  }

  DateTime? get parsedDateOfBirth {
    final raw = dateOfBirth.trim();
    if (raw.isEmpty) return null;

    final parsed = DateTime.tryParse(raw);
    if (parsed != null) return parsed;

    final slash = RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4})$');
    final dash = RegExp(r'^(\d{1,2})-(\d{1,2})-(\d{4})$');
    final slashMatch = slash.firstMatch(raw);
    final dashMatch = dash.firstMatch(raw);
    final match = slashMatch ?? dashMatch;
    if (match == null) return null;

    final day = int.tryParse(match.group(1) ?? '');
    final month = int.tryParse(match.group(2) ?? '');
    final year = int.tryParse(match.group(3) ?? '');
    if (day == null || month == null || year == null) return null;

    final candidate = DateTime(year, month, day);
    if (candidate.year == year &&
        candidate.month == month &&
        candidate.day == day) {
      return candidate;
    }
    return null;
  }

  String get formattedDateOfBirth {
    final dob = parsedDateOfBirth;
    if (dob == null) return dateOfBirth;

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final monthName = months[dob.month - 1];
    final day = dob.day.toString().padLeft(2, '0');
    return '$monthName $day, ${dob.year}';
  }

  String get ageInYearsText {
    final dob = parsedDateOfBirth;
    if (dob == null) return '--';

    final now = DateTime.now();
    var age = now.year - dob.year;
    final hasHadBirthdayThisYear =
        (now.month > dob.month) ||
        (now.month == dob.month && now.day >= dob.day);
    if (!hasHadBirthdayThisYear) age -= 1;

    if (age < 0) return '--';
    return age.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'mobileNumber': mobileNumber,
      'weight': weight,
      'height': height,
      'profilePictureUrl': profilePictureUrl,
      'gender': gender,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> resolveSource() {
      if (json['data'] is Map<String, dynamic>) {
        final data = json['data'] as Map<String, dynamic>;
        if (data['user'] is Map<String, dynamic>) {
          return data['user'] as Map<String, dynamic>;
        }
        if (data['profile'] is Map<String, dynamic>) {
          return data['profile'] as Map<String, dynamic>;
        }
        return data;
      }
      if (json['user'] is Map<String, dynamic>) {
        return json['user'] as Map<String, dynamic>;
      }
      if (json['profile'] is Map<String, dynamic>) {
        return json['profile'] as Map<String, dynamic>;
      }
      return json;
    }

    final source = resolveSource();
    final normalizedSource = <String, dynamic>{};
    source.forEach((key, value) {
      normalizedSource[key.toString().toLowerCase()] = value;
    });

    String readString(List<String> keys) {
      for (final key in keys) {
        final value = source[key] ?? normalizedSource[key.toLowerCase()];
        if (value == null) continue;
        final text = value.toString().trim();
        if (text.isNotEmpty) return text;
      }
      return '';
    }

    return UserProfileModel(
      fullName: readString([
        'fullName',
        'name',
        'userName',
        'username',
        'fullname',
      ]),
      email: readString(['email', 'mail']),
      dateOfBirth: readString([
        'dateOfBirth',
        'birthDate',
        'birthday',
        'dob',
        'dateofbirth',
      ]),
      mobileNumber: readString([
        'mobileNumber',
        'phoneNumber',
        'mobile',
        'phone',
        'mobilenumber',
        'phonenumber',
      ]),
      weight: readString(['weight', 'userWeight']),
      height: readString(['height', 'userHeight']),
      profilePictureUrl: readString([
        'profilePictureUrl',
        'profileImageUrl',
        'imageUrl',
        'avatarUrl',
        'profilepictureurl',
      ]),
      gender: readString(['gender', 'sex']),
    );
  }
}
