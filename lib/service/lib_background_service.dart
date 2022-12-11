import 'package:flutter/foundation.dart';
import 'package:flutter_telegram_crashlytics/tcrash_reporter.dart';
import 'package:workmanager/workmanager.dart';

import '../cache/lib_database.dart';
import '../di/lib_di.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    var reporter = TCrashReporter();
    reporter.initializeDatabase();
    reporter.sync();
    return Future.value(true);
  });
}

class TBackgroundService {
  void initialize() async {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  }

  void start() {
    Workmanager().registerPeriodicTask(
      "sync-task-identifier",
      "sync-task",
      initialDelay: const Duration(minutes: 30),
      frequency: const Duration(hours: 3),
      existingWorkPolicy: ExistingWorkPolicy.keep,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }
}
