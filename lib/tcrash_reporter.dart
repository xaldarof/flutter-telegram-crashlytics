import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_exception_handler/cache/lib_database.dart';
import 'package:flutter_exception_handler/di/lib_di.dart';
import 'package:flutter_exception_handler/telegram_bot_sender.dart';

import 'models/report_remote_model.dart';

class TCrashReporter {
  TelegramBotSender? _telegramBotSender;
  final LibDatabase _database = injector.get<LibDatabase>();

  void init(String botToken, String chatId) {
    _telegramBotSender = TelegramBotSender(botToken: botToken, chatId: chatId);
  }

  void scope(Function runApp) async {
    assert(_telegramBotSender != null);
    _sync();
    runZonedGuarded(() {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        _sendReport(errorDetails.exception.toString());
      };
      runApp.call();
    }, (error, stackTrace) {
      _sendReport(stackTrace.toString());
    });
  }

  void _sendReport(String message) async {
    var insert = _database.into(_database.reportCacheModel);
    _telegramBotSender?.sendReport(message, DateTime.now().toIso8601String(),
        cacheIt: (ReportModel data, String deviceInfo) {
      insert.insert(ReportCacheModelCompanion.insert(
          date: DateTime.now().toIso8601String(),
          exception: message,
          deviceInfo: deviceInfo));
    });
  }

  Future<void> _sync() async {
    var notSyncedTable = _database.select(_database.reportCacheModel);
    var notSyncedList = await notSyncedTable.get();
    await _database.select(_database.reportCacheModel).get();
    for (var element in notSyncedList) {
      _telegramBotSender?.sendReport(
        element.exception,
        element.date,
        cacheIt: (a, b) {},
        onSuccessSync: () async {
          await _database.deleteReport(element.id);
        },
      );
    }
  }
}
