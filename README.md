```dart

void main() {
  //[important] add this line before.
  WidgetsFlutterBinding.ensureInitialized();
  
  var reporter = TCrashReporter();
  reporter.init('botToken', 'chatId');
  reporter.scope(() {
    runApp(const MyApp());
  });
}

```