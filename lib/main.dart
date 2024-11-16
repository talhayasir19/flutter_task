import 'package:flutter/material.dart';
import 'package:flutter_api_task_clean_architecture/core/coreblocs/baseBloc/bloc/base_bloc_bloc.dart';
import 'package:flutter_api_task_clean_architecture/core/coreblocs/baseBloc/bloc/base_bloc_event.dart';
import 'package:flutter_api_task_clean_architecture/core/utils/export.dart';
import 'package:flutter_api_task_clean_architecture/core/utils/navigator_util.dart';
import 'package:flutter_api_task_clean_architecture/layers/presentation/views/calendarScreen/bloc/calendar_screen_bloc.dart';
import 'package:flutter_api_task_clean_architecture/layers/presentation/views/calendarScreen/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'layers/data/datasource/network/export.dart';
import 'layers/data/repository/ApiRepository/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BaseBloc(),
        ),
        BlocProvider(
          create: (context) => CalendarScreenBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigatorUtil.navigatorKey,
        home: const CalendarScreen(),
      ),
    );
  }
}
