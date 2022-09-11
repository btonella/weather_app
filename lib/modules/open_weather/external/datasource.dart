import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/core/api.dart';
import 'package:weather_app/modules/open_weather/domain/errors.dart';
import 'package:weather_app/modules/open_weather/infra/models/weathers.dart';

OpenWeatherFailure getFailureError(Response? response) {
  if (response == null) return OpenWeatherUnkownError();
  switch (response.statusCode) {
    case 400:
      return OpenWeatherRequestError(message: response.statusMessage, data: response.data);
    case 401:
      return OpenWeatherUnauthorizedError(message: response.statusMessage, data: response.data);
    case 403:
      return OpenWeatherForbiddenError(message: response.statusMessage, data: response.data);
    case 404:
      return OpenWeatherRequestError(message: response.statusMessage, data: response.data);
    case 500:
      return OpenWeatherInternalError(message: response.statusMessage, data: response.data);
    default:
      return OpenWeatherUnkownError(message: response.statusMessage, data: response.data);
  }
}

class OpenWeatherDatasource {
  final Api _api = Modular.get<Api>();
  final String _defaultUrl = '';

  Future<Either<OpenWeatherFailure, Weathers>> getWeather() async {
    try {
      Response? response = await _api.getApi('$_defaultUrl/');
      if (response == null || response.statusCode != 200 || response.data == null || response.data is! Map) {
        OpenWeatherFailure failure = getFailureError(response);
        return left(failure);
      } else {
        Weathers weathers = Weathers.fromMap(response.data);
        return right(weathers);
      }
    } catch (e) {
      return left(OpenWeatherUnkownError(message: e.toString()));
    }
  }
}
