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
    //[important] don't forget to add this line
    WidgetsFlutterBinding.ensureInitialized();
  });
}

```

You will get reports like this:
1) All information about device
2) Exception message
3) Date


Example exception report :
![alt text](https://github.com/xaldarof/flutter-telegram-crashlytics/blob/main/assets/report_image.png)

If user is not connected to the internet,all exceptions will be cached while connection will not
available on this device, also library will check connection every 3 hours to try sync data.

I would be very happy if you give me your own suggestion.
([Twitter](https://www.twitter.com/xaldarof))
([Instagram](https://www.instagram.com/xaldarof))
([Telegram](https://www.t.me/xaldarof))

