import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_exception_handler/models/report_model.dart';
import 'package:flutter_exception_handler/networking.dart';
import 'package:flutter_exception_handler/utils/device_info.dart';
import 'package:platform_info_lib/ex.dart';

class TelegramBotSender {
  final DioClient _client = DioClient();
  String botToken = "";
  String chatId = "";

  void setUp(String botToken, String chatId) async {
    this.botToken = botToken;
    this.chatId = chatId;
  }

  void sendReport(String message) async {
    assert(chatId.isNotEmpty);
    assert(botToken.isNotEmpty);
    var device = DeviceInfo();
    _client.post("bot$botToken/sendMessage",
        data: ReportModel(
                chartId: chatId,
                text:
                    "${await device.getDeviceInfo()}\n\n\n\n==================    \n\n$message")
            .toJson());
  }
}
