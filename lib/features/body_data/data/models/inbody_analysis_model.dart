class InbodyAnalysisModel {
  const InbodyAnalysisModel({
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.musclePercentage,
    required this.fatPercentage,
    required this.waterPercentage,
    required this.bmr,
  });

  final int age;
  final String gender;
  final double weight;
  final double height;
  final double musclePercentage;
  final double fatPercentage;
  final double waterPercentage;
  final int bmr;

  factory InbodyAnalysisModel.fromJson(Map<String, dynamic> json) {
    double readDouble(String key) {
      final raw = json[key];
      if (raw is num) return raw.toDouble();
      return double.tryParse(raw?.toString() ?? '') ?? 0;
    }

    int readInt(String key) {
      final raw = json[key];
      if (raw is int) return raw;
      if (raw is num) return raw.toInt();
      return int.tryParse(raw?.toString() ?? '') ?? 0;
    }

    return InbodyAnalysisModel(
      age: readInt('age'),
      gender: (json['gender'] ?? '').toString(),
      weight: readDouble('weight'),
      height: readDouble('height'),
      musclePercentage: readDouble('muscle_percentage'),
      fatPercentage: readDouble('fat_percentage'),
      waterPercentage: readDouble('water_percentage'),
      bmr: readInt('bmr'),
    );
  }
}
