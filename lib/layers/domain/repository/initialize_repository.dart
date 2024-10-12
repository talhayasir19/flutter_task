import 'package:flutter/material.dart';
import 'package:flutter_api_task_clean_architecture/core/coreblocs/baseBloc/bloc/base_bloc_bloc.dart';

abstract class StartupInitializerRepository with WidgetsBindingObserver {
  Future<void> initialize(BaseBloc ref);
  Future<void> updateConnectionStatus(BaseBloc ref);
}
