import 'package:equatable/equatable.dart';

class MainInfos extends Equatable {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  const MainInfos({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  @override
  List<Object?> get props => [];

  static MainInfos fromMap(Map<String, dynamic> map) {
    return MainInfos(
      temp: map['temp'].toDouble(),
      feelsLike: map['feels_like'].toDouble(),
      tempMin: map['temp_min'].toDouble(),
      tempMax: map['temp_max'].toDouble(),
      pressure: map['pressure'],
      humidity: map['humidity'],
    );
  }
}
