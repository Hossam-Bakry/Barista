import 'dart:async';

import 'package:barista/core/config/page_route_names.dart';
import 'package:barista/main.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double scale = 1.0;

  void _changeScale() {
    setState(() => scale = scale == 1.0 ? 1.5 : 1.0);
  }

  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () {
        navigatorKey.currentState?.pushReplacementNamed(PageRouteNames.intro);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    _changeScale();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/splash_background.png",
            width: mediaQuery.width,
            height: mediaQuery.height,
            fit: BoxFit.cover,
          ),
          Image.asset(
            "assets/images/barista_logo.png",
          ),
          /*AnimatedScale(
            scale: scale,
            curve: Curves.bounceOut,
            onEnd: () {
              print("finished");
            },
            duration: const Duration(milliseconds: 650),
            child: Image.asset(
              "assets/images/barista_logo.png",
            ),
          ),*/
        ],
      ),
    );
  }
}
