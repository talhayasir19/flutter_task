import 'dart:developer';

import 'package:flutter_api_task_clean_architecture/core/utils/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/coreblocs/baseBloc/bloc/base_bloc_bloc.dart';
import '../../../core/coreblocs/baseBloc/bloc/base_bloc_event.dart';
import '../../domain/repository/export.dart';

class StartupInitializerRepositoryImpl extends StartupInitializerRepository {
  bool isLightTheme = true;
  static StartupInitializerRepositoryImpl? _instance;
  StartupInitializerRepositoryImpl._internal();

  factory StartupInitializerRepositoryImpl() {
    _instance ??= StartupInitializerRepositoryImpl._internal();

    return _instance!;
  }

  @override
  Future<void> initialize(BaseBloc ref) async {
    log("Initialize called");
    await updateConnectionStatus(ref);
  }

  @override
  Future<void> updateConnectionStatus(BaseBloc ref) async {
    final connectivity = GetIt.I<ConnectivityUtilImpl>();
    final result = await connectivity.giveConnectivityResult();
    ref.add(BaseBlocConnectivityChangedEvent(connectivityResult: result));
    //  subscribe listner for future events
    connectivity.streamConnectivity.listen((result) {
      ref.add(BaseBlocConnectivityChangedEvent(connectivityResult: result[0]));
    });
  }
}
