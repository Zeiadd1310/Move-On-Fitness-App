import 'package:equatable/equatable.dart';

class ReminderModel extends Equatable {
  final int id;
  final String type;
  final String time;

  const ReminderModel({
    required this.id,
    required this.type,
    required this.time,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) => ReminderModel(
    id: json['id'] as int,
    type: json['type'] as String,
    time: json['time'] as String,
  );

  @override
  List<Object?> get props => [id, type, time];
}
