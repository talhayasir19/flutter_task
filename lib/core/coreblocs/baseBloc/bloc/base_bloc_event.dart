import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

@immutable
sealed class BaseBlocEvent {}

class InitializeAppEvent extends BaseBlocEvent {
  InitializeAppEvent();
}

class BaseBlocThemeUpdatedEvent extends BaseBlocEvent {
  bool isLightTheme;
  BaseBlocThemeUpdatedEvent({required this.isLightTheme});
}

class BaseBlocConnectivityChangedEvent extends BaseBlocEvent {
  ConnectivityResult connectivityResult;
  BaseBlocConnectivityChangedEvent({required this.connectivityResult});
}
