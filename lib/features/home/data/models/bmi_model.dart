import 'package:equatable/equatable.dart';

class BmiModel extends Equatable {
  final double? bmi;
  final String? category;

  const BmiModel({this.bmi, this.category});

  factory BmiModel.fromJson(Map<String, dynamic> json) => BmiModel(
    bmi: (json['bmi'] as num?)?.toDouble(),
    category: json['category'] as String?,
  );

  @override
  List<Object?> get props => [bmi, category];
}
