import 'package:barista/core/services/web_service.dart';
import 'package:barista/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String?> getIntroState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("intro");
  }

  Future<String?> getTokenState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("Authorization");
  }

  Future<String> getIntroLangState() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString("introLang") ?? "false";
  }

  Future<bool> checkIntroLang() {
    try {
      return getIntroLangState().then((lang) async {
        if (lang != "false") {
          await navigatorKey.currentState?.context
              .setLocale(Locale(lang.toLowerCase()));
          WebServices().lang = lang.toLowerCase();
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      });
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> isFirstLogin() {
    return getTokenState().then((value) {
      if (value != null) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    });
  }

  Future<bool> isFirstTime() {
    return getIntroState().then((value) {
      if (value != null) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    });
  }
}
