class Configuration {
  static final Configuration _instance = Configuration._();

  Configuration._();

  static Configuration get instance {
    return _instance;
  }

  final baseUrl = "https://www.omdbapi.com/";
  final apiKey = "50770fd4";
}
