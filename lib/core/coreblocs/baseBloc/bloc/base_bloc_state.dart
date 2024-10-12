import 'package:flutter/material.dart';

@immutable
class BaseBlocState {
  bool isInternetConnected;

  BaseBlocState({
    required this.isInternetConnected,
  });
}

final class BaseBlocInitialState extends BaseBlocState {
  BaseBlocInitialState({
    required super.isInternetConnected,
  });
}

final class BaseBlocUpdatedState extends BaseBlocState {
  BaseBlocUpdatedState({
    required super.isInternetConnected,
  });
}

final class BaseBlocShowDisconnectedState extends BaseBlocState {
  BaseBlocShowDisconnectedState({
    required super.isInternetConnected,
  });
}

final class BaseBlocShowConnectionBackState extends BaseBlocState {
  BaseBlocShowConnectionBackState({
    required super.isInternetConnected,
  });
}
