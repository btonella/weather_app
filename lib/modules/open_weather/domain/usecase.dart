import 'package:dartz/dartz.dart';
import 'package:weather_app/modules/open_weather/domain/errors.dart';
import 'package:weather_app/modules/open_weather/infra/models/weather.dart';
import 'package:weather_app/modules/open_weather/infra/repository.dart';

class OpenWeatherUsecase implements OpenWeatherRepository {
  final OpenWeatherRepository _repository = OpenWeatherRepository();

  @override
  Future<Either<OpenWeatherFailure, Weather>> getWeather(String lat, String lon) async {
    try {
      final result = await _repository.getWeather(lat, lon);
      return result.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
    } catch (e) {
      return left(OpenWeatherUnkownError(message: e.toString()));
    }
  }
}
