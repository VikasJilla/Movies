import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:movies/core/exceptions/storage_exception.dart';

abstract class NoSqlStorageContract {
  T? getValue<T>(String key);
  Future<void> setValue<T>(String key, T value);
  Stream listenToKey(String key);
}

class NoSqlStorage implements NoSqlStorageContract {
  static final _instance = NoSqlStorage._();
  late final GetStorage storage;

  NoSqlStorage._();

  Future<void> init() async {
    await GetStorage.init();
    storage = GetStorage();
  }

  factory NoSqlStorage.instance() => _instance;

  @override
  T? getValue<T>(String key) {
    try {
      return storage.read(key);
    } catch (e) {
      throw StorageException();
    }
  }

  @override
  Future<void> setValue<T>(String key, T value) async {
    try {
      await storage.write(key, value);
    } catch (e) {
      throw StorageException();
    }
  }

  @override
  Stream listenToKey(String key) {
    final StreamController controller = StreamController();
    storage.listenKey(key, (value) {
      controller.sink.add(value);
    });
    return controller.stream;
  }
}
