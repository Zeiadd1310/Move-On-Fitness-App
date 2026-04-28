class LogProgressRequest {
  final double weight;
  final double height;
  final double musclePercentage;
  final double fatPercentage;
  final double bmr;
  final String date;

  const LogProgressRequest({
    required this.weight,
    required this.height,
    required this.musclePercentage,
    required this.fatPercentage,
    required this.bmr,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'weight': weight,
    'height': height,
    'musclePercentage': musclePercentage,
    'fatPercentage': fatPercentage,
    'bmr': bmr,
    'date': date,
  };
}
