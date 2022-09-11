import 'package:bloc/bloc.dart';
import 'package:weather_app/modules/open_weather/domain/errors.dart';
import 'package:weather_app/modules/open_weather/domain/usecase.dart';
import 'package:weather_app/modules/open_weather/infra/models/weathers.dart';
import 'package:weather_app/modules/open_weather/presenter/cubit/open_weather_state.dart';

class OpenWeatherCubit extends Cubit<OpenWeatherState> {
  final OpenWeatherUsecase _usecase = OpenWeatherUsecase();

  Weathers? weathers;

  OpenWeatherCubit(OpenWeatherState initialState) : super(initialState);

  void resetState() {
    emit(OpenWeatherInitialState());
  }

  Future<void> getWeather() async {
    try {
      emit(OpenWeatherLoadingState());
      final result = await _usecase.getWeather();
      result.fold((l) {
        emit(OpenWeatherErrorState(l));
        return;
      }, (r) async {
        emit(OpenWeatherSuccessState(weathers: r, weatherStatus: OpenWeatherStatus.getWeather));
        return;
      });
    } catch (e) {
      emit(OpenWeatherErrorState(OpenWeatherUnkownError(message: e.toString())));
    }
  }
}
