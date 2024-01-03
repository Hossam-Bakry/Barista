import 'package:barista/featuers/home/pages/brew_methods_view/brew_play_view.dart';
import 'package:barista/featuers/home/pages/home_layout.dart';
import 'package:flutter/material.dart';

import '../../core/config/page_route_names.dart';
import '../../featuers/auth/pages/forget_password_view.dart';
import '../../featuers/auth/pages/otp_view.dart';
import '../../featuers/auth/pages/reset_password_view.dart';
import '../../featuers/home/pages/brew_methods_view/brew_method_details_view.dart';
import '../../featuers/pages.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteNames.initial:
        return MaterialPageRoute(
            builder: (context) => const SplashView(), settings: settings);
      case PageRouteNames.intro:
        return MaterialPageRoute(
            builder: (context) => const IntroView(), settings: settings);
      case PageRouteNames.login:
        return MaterialPageRoute(
            builder: (context) => AuthView(), settings: settings);
      case PageRouteNames.otp:
        return MaterialPageRoute(
            builder: (context) => OTPView(), settings: settings);
      case PageRouteNames.forgetPassword:
        return MaterialPageRoute(
            builder: (context) => ForgetPasswordView(), settings: settings);
      case PageRouteNames.home:
        return MaterialPageRoute(
            builder: (context) => const HomeLayout(), settings: settings);
      case PageRouteNames.resetPassword:
        return MaterialPageRoute(
            builder: (context) => ResetPasswordView(), settings: settings);
      case PageRouteNames.brewMethodDetails:
        return MaterialPageRoute(
            builder: (context) => const BrewMethodsDetailsView(),
            settings: settings);
      case PageRouteNames.brewPlay:
        return MaterialPageRoute(
            builder: (context) => BrewPlayView(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (context) => const SplashView(), settings: settings);
    }
  }
}
