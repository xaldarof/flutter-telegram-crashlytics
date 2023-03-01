import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_telegram_crashlytics/cache/lib_database.dart';
import 'package:flutter_telegram_crashlytics/di/lib_di.dart';
import 'package:flutter_telegram_crashlytics/service/lib_background_service.dart';
import 'package:flutter_telegram_crashlytics/telegram_bot_sender.dart';

import 'models/report_remote_model.dart';

class TCrashReporter {
  TelegramBotSender? _telegramBotSender;

  void initialize(String botToken, String chatId) {
    _telegramBotSender = TelegramBotSender(botToken: botToken, chatId: chatId);
  }

  void initializeDatabase() {
    injector.registerSingleton<LibDatabase>(LibDatabase());
  }

  void _initializeService() {
    if (Platform.isAndroid || Platform.isIOS) {
      TBackgroundService()
        ..initialize()
        ..start();
    }
  }

  void scope(Function runApp) async {
    assert(_telegramBotSender != null);
    runZonedGuarded(() {
      _initializeService();
      initializeDatabase();
      sync();
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        _sendReport(errorDetails.stack.toString());
      };
      runApp.call();
    }, (error, stackTrace) {
      _sendReport(
        error.toString(),
      );
    });
  }

  void _sendReport(String message) async {
    final LibDatabase database = injector.get<LibDatabase>();
    var insert = database.into(database.reportCacheModel);
    _telegramBotSender?.sendReport(message, DateTime.now().toIso8601String(),
        onError: (ReportModel data, String deviceInfo) {
      insert.insert(ReportCacheModelCompanion.insert(
          date: DateTime.now().toIso8601String(),
          exception: message,
          deviceInfo: deviceInfo));
    }, onSuccessSync: () {
      //
    });
  }

  Future<void> sync() async {
    final LibDatabase database = injector.get<LibDatabase>();
    var notSyncedTable = database.select(database.reportCacheModel);
    var notSyncedList = await notSyncedTable.get();
    for (var element in notSyncedList) {
      _telegramBotSender?.sendReport(
        element.exception,
        element.date,
        onSuccessSync: () async {
          await database.deleteReport(element.id);
        },
      );
    }
  }
}
