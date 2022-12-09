```dart

void main() {
  var reporter = TCrashReporter();
  reporter.init('botToken', 'chatId');
  reporter.scope(() {
    runApp(const MyApp());
  });
}

```