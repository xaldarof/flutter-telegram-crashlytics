import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // print("Native called background task: $backgroundTask"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

class TBackgroundService {
  void initialize() async {
    Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode:
            true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );
    Workmanager().registerOneOffTask("task-identifier", "simpleTask");
  }
}
