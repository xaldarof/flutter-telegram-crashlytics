import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_telegram_crashlytics/cache/lib_database.dart';
import 'package:flutter_telegram_crashlytics/di/lib_di.dart';
import 'package:flutter_telegram_crashlytics/telegram_bot_sender.dart';

import 'models/report_remote_model.dart';

class TCrashReporter {
  TelegramBotSender? _telegramBotSender;

  void init(String botToken, String chatId) {
    _telegramBotSender = TelegramBotSender(botToken: botToken, chatId: chatId);
  }

  void scope(Function runApp) async {
    assert(_telegramBotSender != null);
    runZonedGuarded(() {
      WidgetsFlutterBinding.ensureInitialized();
      injector.registerSingleton<LibDatabase>(LibDatabase());
      _sync();
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        _sendReport(errorDetails.stack.toString().substring(
            0, (errorDetails.exception.toString().length / 3).round()));
      };
      runApp.call();
    }, (error, stackTrace) {
      _sendReport(stackTrace
          .toString()
          .substring(0, (stackTrace.toString().length / 3).round()));
    });
  }

  void _sendReport(String message) async {
    final LibDatabase database = injector.get<LibDatabase>();
    var insert = database.into(database.reportCacheModel);
    _telegramBotSender?.sendReport(message, DateTime.now().toIso8601String(),
        cacheIt: (ReportModel data, String deviceInfo) {
      insert.insert(ReportCacheModelCompanion.insert(
          date: DateTime.now().toIso8601String(),
          exception: message,
          deviceInfo: deviceInfo));
    }, onSuccessSync: () {
      //
    });
  }

  Future<void> _sync() async {
    final LibDatabase database = injector.get<LibDatabase>();
    var notSyncedTable = database.select(database.reportCacheModel);
    var notSyncedList = await notSyncedTable.get();
    await database.select(database.reportCacheModel).get();
    for (var element in notSyncedList) {
      _telegramBotSender?.sendReport(
        element.exception,
        element.date,
        cacheIt: (a, b) {},
        onSuccessSync: () async {
          await database.deleteReport(element.id);
        },
      );
    }
  }
}
