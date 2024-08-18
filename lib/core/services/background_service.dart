import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class BackgroundService {
  /// Foreground and Background
  /// Foreground and Background

  static Future<void> init() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        // notificationChannelId: 'my_foreground',
        // initialNotificationContent: 'running',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // // bring to foreground
    // Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   if (service is AndroidServiceInstance) {
    //     if (await service.isForegroundService()) {
    //       flutterLocalNotificationsPlugin.show(
    //         0, 'This is foreground', '${DateTime.now()}',
    //         const NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             "notificationChannelId",
    //             'MY FOREGROUND SERVICE',
    //             icon: 'ic_bg_service_small',
    //             ongoing: true,
    //           ),
    //         ),
    //       );
    //     }
    //   }
    // });
  }

  static Future<void> backgroundService(Function method) async {
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (isRunning) {
      method();
    } else {
      service.startService();
      if(await service.isRunning()) {
        method();
      }
    }
  }
}
