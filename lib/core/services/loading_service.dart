import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 500.0
    ..maskType = EasyLoadingMaskType.black
    ..backgroundColor = Colors.transparent
    ..textColor = Colors.white
    ..indicatorColor = Colors.transparent
    ..userInteractions = false
    ..dismissOnTap = false;
}
