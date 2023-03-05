import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkConnection {
  Future<bool> isConnected();
}

class NetworkConnectionImpl extends NetworkConnection {
  @override
  Future<bool> isConnected() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
