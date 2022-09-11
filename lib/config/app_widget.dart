import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ignore: must_be_immutable
class AppWidget extends StatelessWidget {
  String appName;
  AppWidget(this.appName, {Key? key}) : super(key: key);

  AppColors appColors = getAppColors();

  @override
  Widget build(BuildContext context) {
    appColors = getAppColors();
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: appName,
      theme: ThemeData(
        textTheme: defaultTextTheme,
        primaryColor: appColors.mainColor(),
        scaffoldBackgroundColor: appColors.black(),
        iconTheme: IconThemeData(color: appColors.black()),
        primaryIconTheme: IconThemeData(color: appColors.black()),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        disabledColor: appColors.grey(),
        errorColor: appColors.error(),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
    );
  }
}
