import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../featuers/auth/provider/auth_provider.dart';
import '../../featuers/auth/provider/forget_password_provider.dart';
import '../../featuers/auth/provider/otp_provider.dart';
import '../../featuers/home/provider/brew_method_provider.dart';
import '../../featuers/home/provider/home_provider.dart';

class AppProviders {
  static final List<SingleChildWidget> _appProviders = [
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => OTPProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ForgetPasswordProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => BrewMethodProvider(),
    ),
  ];

  static Widget multiProviders({
    required Widget child,
  }) {
    return MultiProvider(
      providers: _appProviders,
      child: child,
    );
  }
}
