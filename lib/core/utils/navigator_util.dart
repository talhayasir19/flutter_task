import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigatorUtil {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get state => navigatorKey.currentState!;
  static BuildContext get context => navigatorKey.currentContext!;

  static Future<void> back() async {
    await state.maybePop();
  }

  static Future<void> exitApplication() async {
    if (Platform.isIOS) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      SystemNavigator.pop();
    }
  }

  static Future<void> pop() async {
    state.pop();
  }

  static Future<void> toPushRoute(String route) async {
    await state.pushNamed(route);
  }
}
