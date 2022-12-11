TCrashlytics is a lightweight, realtime crash reporter that helps you track, prioritize, and fix
stability issues that erode your app quality. Set your bot token and chat id to get all crash
reports through telegram bot.

```dart

void main() async {
  var reporter = TCrashReporter();
  var testChatId = "-1001608228640";
  var testBotToken = "5790685024:AAHvA1nscE5-85-6N9nlWHDfl36DiS4GeUA";

  reporter.initialize(testBotToken, testChatId);
  reporter.scope(() {
    runApp(const TCrashReporterExampleApp());
  }, initialize: () {
    WidgetsFlutterBinding.ensureInitialized();
  });
}

```


![alt text](https://github.com/HopeQuotes/Quotes-app-/blob/main/report_image.png)
