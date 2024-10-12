import 'package:flutter_api_task_clean_architecture/layers/data/datasource/local/hive_storage.dart';
import 'package:flutter_api_task_clean_architecture/layers/data/repository/initialize_repository_impl.dart';
import 'package:flutter_api_task_clean_architecture/layers/domain/usecases/export.dart';
import 'package:get_it/get_it.dart';

import '../../layers/data/datasource/network/export.dart';
import '../../layers/data/repository/ApiRepository/export.dart';
import 'export.dart';

abstract class GetItUtil {
  void registerDependencies();
}

class GetItUtilImpl extends GetItUtil {
  @override
  void registerDependencies() async {
    final getIt = GetIt.instance;
    getIt.registerSingleton<DioApiImpl>(DioApiImpl());
    getIt.registerSingleton<HiveStorageImpl>(HiveStorageImpl());
    getIt.registerSingleton<ConnectivityUtilImpl>(ConnectivityUtilImpl());
    getIt.registerSingleton<FlutterToastUtilImpl>(FlutterToastUtilImpl());

    getIt.registerSingleton<DateApiRepositoryImpl>(
        DateApiRepositoryImpl(dioApiImpl: getIt()));
    getIt.registerSingleton<StartupInitializerRepositoryImpl>(
        StartupInitializerRepositoryImpl());
    //Usecases
    getIt.registerSingleton<GetDates>(GetDates(ref: getIt()));
  }
}
