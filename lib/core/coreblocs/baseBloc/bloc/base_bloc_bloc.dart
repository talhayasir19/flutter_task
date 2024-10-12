import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_api_task_clean_architecture/core/coreblocs/baseBloc/bloc/base_bloc_event.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../layers/data/repository/export.dart';
import '../../../../layers/presentation/views/calendarScreen/bloc/calendar_screen_bloc.dart';
import '../../../utils/export.dart';
import 'base_bloc_state.dart';

class BaseBloc extends Bloc<BaseBlocEvent, BaseBlocState> {
  BaseBloc() : super(BaseBlocInitialState(isInternetConnected: true)) {
    on<InitializeAppEvent>((event, emit) async {
      //Startup repo that do necesaary initializations at the start of the app
      log("Event Triggered");
      //register get it
      GetItUtilImpl().registerDependencies();
      //Initialize listners at startup
      await GetIt.I<StartupInitializerRepositoryImpl>().initialize(this);
    });
    on<BaseBlocConnectivityChangedEvent>((event, emit) async {
      log("Connectivity CHanged");
      bool isInternetConnected =
          event.connectivityResult != ConnectivityResult.none;

      if (!isInternetConnected) {
        NavigatorUtil.context
            .read<CalendarScreenBloc>()
            .add(CalendarScreenDataFetchCachedDataEvent());
        emit(BaseBlocShowDisconnectedState(
          isInternetConnected: isInternetConnected,
        ));
      } else {
        NavigatorUtil.context
            .read<CalendarScreenBloc>()
            .add(CalendarScreenDataFetchEvent());
        if (state is! BaseBlocInitialState) {
          GetIt.I<FlutterToastUtilImpl>()
              .showToast(text: "Connection Restored");

          emit(BaseBlocUpdatedState(
            isInternetConnected: isInternetConnected,
          ));
        }
      }
    });
  }
}
