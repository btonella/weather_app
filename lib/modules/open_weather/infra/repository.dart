import 'package:dartz/dartz.dart';
import 'package:weather_app/modules/open_weather/domain/errors.dart';
import 'package:weather_app/modules/open_weather/external/datasource.dart';
import 'package:weather_app/modules/open_weather/infra/models/weathers.dart';

class OpenWeatherRepository implements OpenWeatherDatasource {
  final OpenWeatherDatasource _datasource = OpenWeatherDatasource();

  @override
  Future<Either<OpenWeatherFailure, Weathers>> getWeather() async {
    try {
      final result = await _datasource.getWeather();
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
