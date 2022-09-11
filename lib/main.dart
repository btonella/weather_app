import 'package:weather_app/config/app_flavor.dart';
import 'package:weather_app/config/app_module.dart';
import 'package:weather_app/config/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() => initApp();

void initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  AppFlavor appFlavor = AppFlavor();
  await appFlavor.initPackageInfo();
  String appName = appFlavor.getAppName();

  return runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(appName),
    ),
  );
}
