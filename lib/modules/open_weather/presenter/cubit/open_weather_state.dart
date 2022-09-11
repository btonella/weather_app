import 'package:equatable/equatable.dart';
import 'package:weather_app/modules/open_weather/domain/errors.dart';
import 'package:weather_app/modules/open_weather/infra/models/weathers.dart';

enum OpenWeatherStatus { getWeather }

abstract class OpenWeatherState extends Equatable {}

class OpenWeatherInitialState extends OpenWeatherState {
  @override
  List<Object> get props => [];
}

class OpenWeatherLoadingState extends OpenWeatherState {
  @override
  List<Object> get props => [];
}

class OpenWeatherSuccessState extends OpenWeatherState {
  final Weathers weathers;
  final OpenWeatherStatus weatherStatus;
  OpenWeatherSuccessState({required this.weathers, required this.weatherStatus});

  @override
  List<Object> get props => [];
}

class OpenWeatherErrorState extends OpenWeatherState {
  final OpenWeatherFailure failure;
  OpenWeatherErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}
