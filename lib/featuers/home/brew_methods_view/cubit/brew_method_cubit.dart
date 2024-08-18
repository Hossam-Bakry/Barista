import 'dart:async';

import 'package:barista/core/services/background_service.dart';
import 'package:barista/core/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brew_method_state.dart';


class BrewMethodCubit extends Cubit<BrewMethodState> {
  BrewMethodCubit() : super(BrewMethodInitial());
  static BrewMethodCubit get(context) => BlocProvider.of(context);

  void getBrewMethod() {
    NotificationService.showNotification(id: 1,title: "title", body: "body",scheduled: true, interval: 60);
    NotificationService.showNotification(id: 2, title: "title2", body: "body2",scheduled: true, interval: 120);
    NotificationService.showNotification(id: 3, title: "title3", body: "body3",scheduled: true, interval: 200);
  }
}
