import 'package:dartz/dartz.dart';
import 'package:weather_app/modules/open_weather/domain/errors.dart';
import 'package:weather_app/modules/open_weather/infra/models/weathers.dart';
import 'package:weather_app/modules/open_weather/infra/repository.dart';

class OpenWeatherUsecase implements OpenWeatherRepository {
  final OpenWeatherRepository _repository = OpenWeatherRepository();

  @override
  Future<Either<OpenWeatherFailure, Weathers>> getWeather() async {
    try {
      final result = await _repository.getWeather();
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
