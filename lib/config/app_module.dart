// ignore_for_file: prefer_const_constructors

import 'package:weather_app/config/app_flavor.dart';
import 'package:weather_app/config/app_geolocator.dart';
import 'package:weather_app/config/app_preferences.dart';
import 'package:weather_app/core/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/modules/open_weather/presenter/cubit/open_weather_cubit.dart';
import 'package:weather_app/modules/open_weather/presenter/cubit/open_weather_state.dart';
import 'package:weather_app/modules/open_weather/presenter/home_page.dart';
import 'package:weather_app/modules/open_weather/presenter/weather_details_page.dart';

class AppModule extends Module {
  AppModule();

  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),

        // cubit
        Bind((i) => OpenWeatherCubit(OpenWeatherInitialState())),

        // configs
        Bind((i) => AppPreferences()),
        Bind((i) => AppFlavor()),
        Bind((i) => Api()),
        Bind((i) => AppGeolocator()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => HomePage()),
        ChildRoute('/details', child: (context, args) => WeatherDetailsPage(args.data)),
      ];
}
