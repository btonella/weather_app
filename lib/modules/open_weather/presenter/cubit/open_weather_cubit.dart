import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/common/constants.dart';
import 'package:weather_app/config/app_geolocator.dart';
import 'package:weather_app/modules/open_weather/domain/errors.dart';
import 'package:weather_app/modules/open_weather/domain/usecase.dart';
import 'package:weather_app/modules/open_weather/infra/models/weather.dart';
import 'package:weather_app/modules/open_weather/presenter/cubit/open_weather_state.dart';

class OpenWeatherCubit extends Cubit<OpenWeatherState> {
  final AppGeolocator appGeolocator = Modular.get<AppGeolocator>();
  final OpenWeatherUsecase _usecase = OpenWeatherUsecase();

  List<Weather>? weathers;
  Weather? cityWeather;

  OpenWeatherCubit(OpenWeatherState initialState) : super(initialState);

  void resetState() {
    emit(OpenWeatherInitialState());
  }

  void cleanState() {
    emit(OpenWeatherInitialState());
    weathers = null;
  }

  void emitSuccess(OpenWeatherStatus weatherStatus) {
    emit(OpenWeatherSuccessState(weathers: weathers, cityWeather: cityWeather, weatherStatus: weatherStatus));
  }

  Future<Map<String, String>> getMyLocation() async {
    final map = {'lat': '', 'lon': '', 'name': 'Minha Localizaçao'};
    try {
      if (appGeolocator.hasPermission()) {
        final Position position = await appGeolocator.getMyLocation();
        map['lat'] = position.latitude.toString();
        map['lon'] = position.longitude.toString();
        return map;
      } else {
        return map;
      }
    } catch (e) {
      return map;
    }
  }

  Future<void> getAllWeathers() async {
    try {
      emit(OpenWeatherLoadingState());
      List<Weather> results = [];
      final myLocation = await getMyLocation();
      if (myLocation['lat']!.isNotEmpty && myLocation['lon']!.isNotEmpty) listPositions[0] = myLocation;
      for (var map in listPositions) {
        OpenWeatherFailure? failure;
        final result = await _usecase.getWeather(map['lat']!, map['lon']!);
        result.fold((l) {
          failure = l;
          return;
        }, (r) {
          if (map['name'] == 'Minha Localizaçao') {
            r.isMyWeather = true;
          } else {
            r.name = map['name'];
          }
          results.add(r);
          return;
        });
        if (failure != null) {
          emit(OpenWeatherErrorState(failure!));
          break;
        }
      }
      if (results.length == listPositions.length) {
        weathers = results;
        emitSuccess(OpenWeatherStatus.getWeather);
      }
      return;
    } catch (e) {
      emit(OpenWeatherErrorState(OpenWeatherUnkownError(message: e.toString())));
    }
  }

  Future<void> getCityWeather(String name) async {
    try {
      cityWeather = null;
      emit(OpenWeatherLoadingState());
      final result = await _usecase.getCityWeather(name);
      result.fold((l) {
        emit(OpenWeatherErrorState(l));
        return;
      }, (r) async {
        cityWeather = r;
        emitSuccess(OpenWeatherStatus.getCityWeather);
        return;
      });
    } catch (e) {
      emit(OpenWeatherErrorState(OpenWeatherUnkownError(message: e.toString())));
    }
  }
}
