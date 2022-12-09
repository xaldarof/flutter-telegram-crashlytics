import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_exception_handler/telegram_bot_sender.dart';

class TCrashReporter {
  TelegramBotSender? _telegramBotSender;

  void setUp(String botToken, String chatId) async {}

  void init(String botToken, String chatId) {
    _telegramBotSender = TelegramBotSender(botToken: botToken, chatId: chatId);
  }

  void scope(Function runApp) {
    assert(_telegramBotSender != null);
    runZonedGuarded(() {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        print("log on error: ${errorDetails.exception.toString()}");
        _telegramBotSender?.sendReport(errorDetails.exception.toString());
      };
      runApp.call();
    }, (error, stackTrace) {
      _telegramBotSender?.sendReport(stackTrace.toString());
      print("log error : ${stackTrace.toString()}");
    });
  }
}
