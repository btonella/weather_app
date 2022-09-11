import 'package:equatable/equatable.dart';

class WeatherInfos extends Equatable {
  final String main;
  final String description;
  final String icon;

  const WeatherInfos({
    required this.main,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [];

  static WeatherInfos fromMap(Map<String, dynamic> map) {
    return WeatherInfos(
      main: map['main'],
      description: map['description'],
      icon: map['icon'],
    );
  }
}
