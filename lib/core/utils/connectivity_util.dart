import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityUtil {
  Future<bool> checkConnectivity();
  Future<ConnectivityResult> giveConnectivityResult();
}

class ConnectivityUtilImpl extends ConnectivityUtil {
  late Connectivity connectivity;
  late Stream<List<ConnectivityResult>> streamConnectivity;
  static ConnectivityUtilImpl? instance;

  factory ConnectivityUtilImpl() {
    return instance ??= ConnectivityUtilImpl._internal();
  }

  ConnectivityUtilImpl._internal() {
    connectivity = Connectivity();
    streamConnectivity = connectivity.onConnectivityChanged;
  }
  @override
  Future<bool> checkConnectivity() async {
    final result = await connectivity.checkConnectivity();
    return result[0] != ConnectivityResult.none;
  }

  @override
  Future<ConnectivityResult> giveConnectivityResult() async {
    final result = await connectivity.checkConnectivity();
    return result[0];
  }
}
