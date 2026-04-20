/// Maps API [dayType] labels to bundled assessment-style cover images.
/// Uses files under [assets/images/] (same style as the Assessment screen).
String resolveWorkoutDayCoverPath(String dayType) {
  final t = dayType.trim().toLowerCase().replaceAll('_', ' ');
  if (t.isEmpty) return '';

  if (t.contains('full body')) return 'assets/images/full body.png';
  if (t.contains('upper body')) return 'assets/images/upper body.png';
  if (t.contains('lower body')) return 'assets/images/lower body.png';

  if (t.contains('chest and triceps')) {
    return 'assets/images/chest and triceps.png';
  }
  if (t.contains('shoulder and')) {
    return 'assets/images/shoulder and trapzeius.png';
  }
  if (t.contains('leg and abs') || t.contains('legs and abs')) {
    return 'assets/images/leg and abs.png';
  }

  if (t.contains('leg day') || t == 'legs' || t == 'leg') {
    return 'assets/images/leg day.png';
  }
  if (t.contains('push')) return 'assets/images/push day.png';
  if (t.contains('pull')) return 'assets/images/pull day.png';

  if (t.contains('shoulder')) return 'assets/images/shoulder.png';
  if (t.contains('chest')) return 'assets/images/chest.png';
  if (t.contains('bice') && t.contains('back')) {
    return 'assets/images/back and bicebs.png';
  }
  if (t.contains('back')) return 'assets/images/back.png';
  if (t.contains('arm')) return 'assets/images/arms.png';

  return '';
}
