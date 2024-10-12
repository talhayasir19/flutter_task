import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/coreblocs/baseBloc/bloc/base_bloc_bloc.dart';
import '../../../../core/coreblocs/baseBloc/bloc/base_bloc_event.dart';
import '../../../data/datasource/local/export.dart';
import '../../../data/models/export.dart';
import 'bloc/calendar_screen_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BaseBloc>().add(InitializeAppEvent());
    // context.read<CalendarScreenBloc>().add(CalendarScreenDataFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Dates Data"),
      ),
      body: BlocBuilder<CalendarScreenBloc, CalendarScreenState>(
        builder: (context, state) {
          if (state is CalendarScreenLoadedState) {
            final model = state.model;
            return Center(
              child: Column(
                children: [
                  Text(
                    'Last Cached Time ${state.lastCached}',
                  ),
                  const Text(
                    'Hijri Data',
                  ),
                  Text(
                    model?.hijri.date ?? '--',
                  ),
                  const Text(
                    'Gregorian Data',
                  ),
                  Text(
                    model?.gregorian.date ?? '--',
                  ),
                ],
              ),
            );
          } else if (state is CalendarScreenLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CalendarScreenErrorState) {
            return const Center(
              child: const Text(
                'Something Went WRong',
              ),
            );
          }
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'No Data Found',
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
          }
        },
      ),
    );
  }
}
