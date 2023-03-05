import 'package:kiwi/kiwi.dart';

class DependencyResolver {
  static final _instance = DependencyResolver._();
  DependencyResolver._();

  factory DependencyResolver() => _instance;

  T getType<T>() {
    return KiwiContainer().resolve<T>();
  }
}
