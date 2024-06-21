import 'package:barista/core/config/application_theme.dart';
import 'package:barista/core/config/page_route_names.dart';
import 'package:barista/core/config/routes.dart';
import 'package:barista/core/services/loading_service.dart';
import 'package:barista/core/services/notification_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'core/config/providers.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("en"),
        Locale("ar"),
      ],
      path: "assets/translations",
      startLocale: const Locale("en"),
      fallbackLocale: const Locale("en"),
      useOnlyLangCode: true,
      child: Phoenix(
        child: const MyApp(),
      ),
    ),
  );

  configLoading();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppProviders.multiProviders(
      child: MaterialApp(
        title: 'Barista',
        theme: ApplicationTheme.lightTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: navigatorKey,
        initialRoute: PageRouteNames.initial,
        onGenerateRoute: Routes.generateRoute,
        builder: EasyLoading.init(
          builder: BotToastInit(),
        ),
      ),
    );
  }
}

