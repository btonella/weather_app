// ignore_for_file: prefer_null_aware_operators, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:weather_app/modules/open_weather/infra/models/clouds.dart';
import 'package:weather_app/modules/open_weather/infra/models/main_infos.dart';
import 'package:weather_app/modules/open_weather/infra/models/sun_infos.dart';
import 'package:weather_app/modules/open_weather/infra/models/weather_infos.dart';
import 'package:weather_app/modules/open_weather/infra/models/wind.dart';

class Weather extends Equatable {
  String? name;
  final WeatherInfos? infos;
  final MainInfos? mainInfos;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final SunInfos? sunInfo;

  Weather({
    this.name,
    this.infos,
    this.mainInfos,
    this.visibility,
    this.wind,
    this.clouds,
    this.sunInfo,
  });

  @override
  List<Object?> get props => [];

  static Weather fromMap(Map<String, dynamic> map) {
    return Weather(
      name: map['name'],
      infos: map['weather'] != null ? map['weather'].map<WeatherInfos>((e) => WeatherInfos.fromMap(e)).toList().first : null,
      mainInfos: map['main'] != null ? MainInfos.fromMap(map['main']) : null,
      visibility: map['visibility'],
      wind: map['wind'] != null ? Wind.fromMap(map['wind']) : null,
      clouds: map['clouds'] != null ? Clouds.fromMap(map['clouds']) : null,
      sunInfo: map['sys'] != null ? SunInfos.fromMap(map['sys']) : null,
    );
  }
}
