import 'dart:async';
import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

enum ObjectType {
  calendarData(name: 'userModel'),
  lastCacheData(name: 'lastCahedData');

  const ObjectType({required this.name});
  final String name;
}

abstract class HiveStorage {
  abstract String dataBaseName;
  abstract String userTableName;
  Future<void> init();

  Future<void> truncate();

  Future<void> addObject(
      {required Map<String, dynamic> map, required ObjectType objectType});

  Future<T?> getObject<T>(
      {required T Function(Map<dynamic, dynamic> object) cast,
      required ObjectType objectType});
}

class HiveStorageImpl extends HiveStorage {
  late final CollectionBox<Map> box;

  HiveStorageImpl() {
    unawaited(init());
  }

  @override
  String dataBaseName = 'CalendarDataBase';

  @override
  String userTableName = 'DateTable';
  @override
  Future<void> init() async {
    try {
      final appDocDirectory = await getApplicationDocumentsDirectory();

      final boxCollection = await BoxCollection.open(
        dataBaseName, // Name of your database
        {userTableName}, // Names of your boxes
        path: '${appDocDirectory.path}/',
      );
      box = await boxCollection.openBox(userTableName);
    } catch (e) {
      log('Exception $e');
    }
  }

  @override
  Future<void> addObject(
      {required Map<String, dynamic> map,
      required ObjectType objectType}) async {
    await init();
    await box.put(objectType.name, map);
  }

  @override
  Future<T?> getObject<T>(
      {required T Function(Map<dynamic, dynamic> object) cast,
      required ObjectType objectType}) async {
    await init();

    final map = await box.get(objectType.name);
    Map<dynamic, dynamic>? myMap = map;

    if (myMap != null) {
      log("Map run time type $myMap");
      final object = cast(myMap);
      return object;
    }
    return null;
  }

  @override
  Future<void> truncate() async {
    await init();

    await box.clear();
  }
}
