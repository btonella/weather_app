import 'package:dartz/dartz.dart';
import 'package:weather_app/modules/open_weather/domain/errors.dart';
import 'package:weather_app/modules/open_weather/external/datasource.dart';
import 'package:weather_app/modules/open_weather/infra/models/weather.dart';

class OpenWeatherRepository implements OpenWeatherDatasource {
  final OpenWeatherDatasource _datasource = OpenWeatherDatasource();

  @override
  Future<Either<OpenWeatherFailure, Weather>> getWeather(String lat, String lon) async {
    try {
      final result = await _datasource.getWeather(lat, lon);
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
