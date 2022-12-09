import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_exception_handler/telegram_bot_sender.dart';

class TCrashReporter {
  TCrashReporter();

  final telegramBotSender = TelegramBotSender();

  void scope(Function runApp) {
    telegramBotSender.setUp("5790685024:AAHvA1nscE5-85-6N9nlWHDfl36DiS4GeUA", "827790539");
    runZonedGuarded(() {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        print("log on error: ${errorDetails.exception.toString()}");
        telegramBotSender.sendReport(errorDetails.exception.toString());
      };
      runApp.call();
    }, (error, stackTrace) {
      telegramBotSender.sendReport(stackTrace.toString());
      print("log error : ${stackTrace.toString()}");
    });
  }
}
