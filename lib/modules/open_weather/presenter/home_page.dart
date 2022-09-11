// ignore_for_file: iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/config/app_geolocator.dart';
import 'package:weather_app/modules/open_weather/infra/models/weather.dart';
import 'package:weather_app/modules/open_weather/presenter/cubit/open_weather_cubit.dart';
import 'package:weather_app/modules/open_weather/presenter/cubit/open_weather_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OpenWeatherCubit openWeatherCubit = Modular.get<OpenWeatherCubit>();
  AppGeolocator appGeolocator = Modular.get<AppGeolocator>();
  AppColors appColors = getAppColors();
  bool hasGeolocationPermission = false;

  @override
  void initState() {
    super.initState();
    appGeolocator.askPermission().then((value) {
      setState(() => hasGeolocationPermission = value == null);
      openWeatherCubit.getAllWeathers();
    });
  }

  Widget locationNotFoundWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Text('Nao foi possível encontrar a sua localizaçao'),
    );
  }

  Widget buildWeatherCard(Weather weather) {
    return GestureDetector(
      onTap: () => Modular.to.pushNamed('/details', arguments: weather),
      child: Container(
        decoration: BoxDecoration(
          color: appColors.grey(),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Text(weather.mainInfos != null ? '${weather.mainInfos!.temp}°C' : '-'),
            Column(
              children: [
                Text(weather.name ?? ''),
                Text(weather.infos?.description ?? ''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildList(List<Weather> weathers) {
    List<Widget> result = [];
    bool hasMyLocation = weathers.first.mainInfos != null;
    if (!hasGeolocationPermission || !hasMyLocation) result.add(locationNotFoundWidget());
    result.addAll(weathers.map((e) => buildWeatherCard(e)).toList());
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App'), backgroundColor: appColors.mainColor()),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer(
          bloc: openWeatherCubit,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OpenWeatherLoadingState) return CircularProgressIndicator(color: appColors.mainColor());

            return RefreshIndicator(
              onRefresh: () => openWeatherCubit.getAllWeathers(),
              child: ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: state is OpenWeatherSuccessState ? buildList(state.weathers) : [],
              ),
            );
          },
        ),
      ),
    );
  }
}
