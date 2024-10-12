import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_api_task_clean_architecture/layers/data/datasource/local/hive_storage.dart';
import 'package:flutter_api_task_clean_architecture/layers/domain/usecases/export.dart';
import 'package:get_it/get_it.dart';

import 'package:meta/meta.dart';

import '../../../../data/models/export.dart';
import '../../../../domain/entity/export.dart';

part 'calendar_screen_event.dart';
part 'calendar_screen_state.dart';

class CalendarScreenBloc
    extends Bloc<CalendarScreenEvent, CalendarScreenState> {
  CalendarScreenBloc() : super(CalendarScreenInitialState()) {
    on<CalendarScreenDataFetchEvent>((event, emit) async {
      emit(CalendarScreenLoadingState());
      Either<ApiError, ApiResult<CalendarDataModel?>> value =
          await GetIt.I<GetDates>().call();
      if (value is Right) {
        //Storing data to local data base
        final lastCahedtime = DateTime.now().toString();

        HiveStorageImpl hiveDataBase = GetIt.I<HiveStorageImpl>();
        await hiveDataBase.addObject(
            map: value.right.data!.toJson(),
            objectType: ObjectType.calendarData);
        await hiveDataBase.addObject(
            map: {'lastCached': DateTime.now().toString()},
            objectType: ObjectType.lastCacheData);

        log("Data Cached Successfully");

        emit(CalendarScreenLoadedState(
            model: value.right.data!, lastCached: lastCahedtime));
      } else {
        log("Something error ${value.left.message}");
        emit(CalendarScreenErrorState());
      }
    });
    on<CalendarScreenDataFetchCachedDataEvent>((event, emit) async {
      log("Cached event triggered");

      emit(CalendarScreenLoadingState());
      final cacheData = await GetIt.I<HiveStorageImpl>()
          .getObject<CalendarDataModel>(
              cast: CalendarDataModel.fromJson,
              objectType: ObjectType.calendarData);

      log("Cached Data");
      if (cacheData != null) {
        final lastCachedTime =
            await GetIt.I<HiveStorageImpl>().getObject<String>(
                cast: (object) {
                  final lastCahedTime = object['lastCached'] as String;
                  return lastCahedTime;
                },
                objectType: ObjectType.lastCacheData);
        emit(CalendarScreenLoadedState(
            model: cacheData, lastCached: lastCachedTime!));
      } else {
        emit(CalendarScreenNoDataFoundState());
      }
    });
  }
}
