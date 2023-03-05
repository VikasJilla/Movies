import 'package:logger/logger.dart';

/*
  For Reference
  Logger Levels : Error>Warning>Info>Debug>Verbose
*/

var logger = Logger(
  level: Level.debug,
  printer: AppLogPrinter(),
);

class AppLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    return [event.message.toString()];
  }
}
