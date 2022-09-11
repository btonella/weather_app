// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class SunInfos extends Equatable {
  final int type;
  final int id;
  final String country;
  DateTime? sunrise;
  DateTime? sunset;

  SunInfos({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  @override
  List<Object?> get props => [];

  static SunInfos fromMap(Map<String, dynamic> map) {
    return SunInfos(
      type: map['type'],
      id: map['id'],
      country: map['country'],
      sunrise: map['sunrise'] != null ? DateTime.fromMillisecondsSinceEpoch(map['sunrise'] * 1000, isUtc: true) : null,
      sunset: map['sunset'] != null ? DateTime.fromMillisecondsSinceEpoch(map['sunset'] * 1000, isUtc: true) : null,
    );
  }
}
