import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/theme.dart';
import 'package:weather_app/modules/open_weather/infra/models/rain.dart';
import 'package:weather_app/modules/open_weather/infra/models/snow.dart';
import 'package:weather_app/modules/open_weather/infra/models/weather.dart';

class WeatherDetailsPage extends StatefulWidget {
  final Weather weather;
  const WeatherDetailsPage(this.weather, {Key? key}) : super(key: key);

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  late Weather weather;
  AppColors appColors = getAppColors();

  @override
  void initState() {
    super.initState();
    weather = widget.weather;
    if (weather.isMyWeather && weather.sunInfo != null) {
      weather.sunInfo!.sunrise = weather.sunInfo!.sunrise!.toLocal();
      weather.sunInfo!.sunset = weather.sunInfo!.sunset!.toLocal();
    }
  }

  Widget buildCard(String title, String value, {Widget? extraValue, Widget? genericCard}) {
    return Container(
      decoration: BoxDecoration(
        color: appColors.background(),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      child: genericCard ??
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Row(
                children: [
                  Text(value),
                  extraValue ?? Container(),
                ],
              )
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.weather.name ?? ''), backgroundColor: appColors.mainColor()),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: appColors.background(),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 40),
              margin: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    weather.mainInfos != null ? '${weather.mainInfos!.temp.toInt()}°C' : '-',
                    style: defaultTextTheme.headline1?.copyWith(fontSize: 80),
                  ),
                  Text(weather.infos?.description ?? ''),
                ],
              ),
            ),
            buildCard(
              'Previsao: ',
              '${weather.mainInfos?.tempMin.toInt()}°/${weather.mainInfos?.tempMax.toInt()}°',
            ),
            buildCard(
              'Humidade: ',
              weather.mainInfos?.humidity.toString() ?? '',
              extraValue: Container(padding: const EdgeInsets.only(left: 5), child: Icon(Icons.water_drop, color: appColors.blue(), size: 15)),
            ),
            buildCard(
              'Velocidade dos ventos: ',
              '${weather.wind?.speed ?? ''} m/s',
            ),
            buildCard(
              'Nuvens: ',
              '${weather.clouds?.all ?? ''} %',
            ),
            buildCard(
              '',
              '',
              genericCard: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sol'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nascer'),
                      Text(
                        DateFormat('dd/MM/yyyy, HH:mm').format(weather.sunInfo!.sunrise!),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Por'),
                      Text(
                        DateFormat('dd/MM/yyyy, HH:mm').format(weather.sunInfo!.sunset!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            weather.rain != null
                ? buildCard('', '',
                    genericCard: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Volume de chuva'),
                        const SizedBox(height: 10),
                        weather.rain?.last1h != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Na última 1 hora'),
                                  Row(
                                    children: [
                                      Text(
                                        '${weather.rain?.last1h ?? ''} mm',
                                      ),
                                      Container(padding: const EdgeInsets.only(left: 5), child: const Icon(Icons.cloudy_snowing, size: 15)),
                                    ],
                                  )
                                ],
                              )
                            : Container(),
                        const SizedBox(height: 5),
                        weather.rain?.last3h != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Nas últimas 3 hora'),
                                  Row(
                                    children: [
                                      Text(
                                        '${weather.rain?.last3h ?? ''} mm',
                                      ),
                                      Container(padding: const EdgeInsets.only(left: 5), child: const Icon(Icons.cloudy_snowing, size: 15)),
                                    ],
                                  )
                                ],
                              )
                            : Container(),
                      ],
                    ))
                : Container(),
            weather.snow != null
                ? buildCard('', '',
                    genericCard: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Volume de neve'),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Na última 1 hora'),
                            Row(
                              children: [
                                Text(
                                  '${weather.snow?.last1h ?? ''} mm',
                                ),
                                Container(padding: const EdgeInsets.only(left: 5), child: const Icon(Icons.cloudy_snowing, size: 15)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Nas últimas 3 hora'),
                            Row(
                              children: [
                                Text(
                                  '${weather.snow?.last3h ?? ''} mm',
                                ),
                                Container(padding: const EdgeInsets.only(left: 5), child: const Icon(Icons.cloudy_snowing, size: 15)),
                              ],
                            )
                          ],
                        ),
                      ],
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
