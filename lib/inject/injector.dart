import 'package:kiwi/kiwi.dart';
import 'package:movies/core/local_storage/no_sql_storage.dart';
import 'package:movies/core/network/network_client.dart';
import 'package:movies/core/network_info.dart';

import '../core/network/dio_client.dart';

class Injector {
  Future<void> configure() async {
    KiwiContainer container = KiwiContainer();
    container.registerSingleton<NetworkClient>((container) => DioClient());
    container.registerSingleton<NoSqlStorageContract>(
        (container) => NoSqlStorage.instance());
    container.registerSingleton<NetworkConnection>(
        (container) => NetworkConnectionImpl());
    await NoSqlStorage.instance().init();
  }
}
