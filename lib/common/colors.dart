// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

AppColors getAppColors() {
  return AppColors();
}

class AppColors {
  mainColor() => Color(0xFFFEC92D);
  secondColor() => Color(0xff99731F);
  grey() => Color(0xFFF6F6F6);
  darkGrey() => Color(0xFF303030);
  white() => Colors.white;
  black() => Colors.black;
  background() => Color(0xFFFCFCFC);
  backgroundOpposite() => Colors.black;
  error() => Colors.red;
}
