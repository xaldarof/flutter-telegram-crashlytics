import 'package:flutter_telegram_crashlytics/cache/lib_database.dart';
import 'package:get_it/get_it.dart';

var injector = GetIt.instance;

void initDependencies() {
  injector.registerSingleton<LibDatabase>(LibDatabase());
}
