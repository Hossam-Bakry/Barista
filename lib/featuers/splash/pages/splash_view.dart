import 'dart:async';

import 'package:barista/core/config/page_route_names.dart';
import 'package:barista/core/services/web_service.dart';
import 'package:barista/featuers/splash/provider/splash_provider.dart';
import 'package:barista/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/sound_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double scale = 1.0;
  late final SharedPreferences prefs;

  void _changeScale() {
    setState(() => scale = scale == 1.0 ? 1.5 : 1.0);
  }

  @override
  initState() {
    SoundService.instance.loadSounds();
    WebServices().initializeToken();
    Future.wait([
      Provider.of<SplashProvider>(context, listen: false).isFirstTime(),
      // Provider.of<SplashProvider>(context, listen: false).isFirstLogin(),
      Provider.of<SplashProvider>(context, listen: false).checkIntroLang(),
      Future.delayed(const Duration(seconds: 2)),
    ]).then((value) {
      if (value[0]) {
        navigatorKey.currentState?.pushReplacementNamed(PageRouteNames.intro);
      } else {
        WebServices().getMobileToken().then((value) {
          print(value);

          if (value == null) {
            navigatorKey.currentState
                ?.pushReplacementNamed(PageRouteNames.login);
          } else {
            navigatorKey.currentState
                ?.pushReplacementNamed(PageRouteNames.home);
          }
        });
        // if (value[1]) {
        //   navigatorKey.currentState?.pushReplacementNamed(PageRouteNames.login);
        // } else {
        //   navigatorKey.currentState?.pushReplacementNamed(PageRouteNames.home);
        // }
      }
    });
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
