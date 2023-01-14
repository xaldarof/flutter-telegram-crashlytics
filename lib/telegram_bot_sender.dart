import 'package:flutter_telegram_crashlytics/models/report_remote_model.dart';
import 'package:flutter_telegram_crashlytics/networking.dart';
import 'package:flutter_telegram_crashlytics/utils/device_info.dart';
import 'package:flutter_telegram_crashlytics/utils/str_ext.dart';

class TelegramBotSender {
  final DioClient _client = DioClient();
  final DeviceInfo _device = DeviceInfo();

  final String botToken;
  final String chatId;

  void sendReport(String message, String date,
      {Function(ReportModel data, String deviceInfo)? onError,
      Function? onSuccessSync}) async {
    assert(chatId.isNotEmpty);
    assert(botToken.isNotEmpty);
    var deviceInfo = (await _device.getDeviceInfo());
    var clipped = deviceInfo.ellipsize(800);

    var data = ReportModel(
        chartId: chatId,
        text:
            "<==============DEVICE=================> \n\n$clipped\n\n\n\n<==============ERROR=================>\n\n\n${message.ellipsize(3000)} \n\n\n$date");
    try {
      var response =
          await _client.post("bot$botToken/sendMessage", data: data.toJson());
      if (response.isSuccessful) onSuccessSync?.call();
    } catch (e) {
      onError?.call(data, deviceInfo);
    }
  }

  TelegramBotSender({
    required this.botToken,
    required this.chatId,
  });
}
