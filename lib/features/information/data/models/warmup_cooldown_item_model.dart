import 'package:equatable/equatable.dart';

class WarmupCooldownItem extends Equatable {
  final String name;
  final String duration;

  const WarmupCooldownItem({required this.name, required this.duration});

  factory WarmupCooldownItem.fromJson(Map<String, dynamic> json) =>
      WarmupCooldownItem(
        name: json['name']?.toString() ?? '',
        duration: json['duration']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {'name': name, 'duration': duration};

  @override
  List<Object?> get props => [name, duration];
}
