import 'package:flutter/material.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/modules/open_weather/infra/models/weather.dart';

class WeatherDetailsPage extends StatefulWidget {
  final Weather weather;
  const WeatherDetailsPage(this.weather, {Key? key}) : super(key: key);

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  AppColors appColors = getAppColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.weather.name ?? ''), backgroundColor: appColors.mainColor()),
      body: Column(children: []),
    );
  }
}
