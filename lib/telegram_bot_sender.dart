import 'package:flutter_exception_handler/models/report_remote_model.dart';
import 'package:flutter_exception_handler/networking.dart';
import 'package:flutter_exception_handler/utils/device_info.dart';

class TelegramBotSender {
  final DioClient _client = DioClient();
  final DeviceInfo _device = DeviceInfo();

  final String botToken;
  final String chatId;

  void sendReport(String message, String date,
      {required Function(ReportModel data, String deviceInfo) cacheIt,
      Function? onSuccessSync}) async {
    assert(chatId.isNotEmpty);
    assert(botToken.isNotEmpty);
    var deviceInfo = await _device.getDeviceInfo();
    var data = ReportModel(
        chartId: chatId,
        text:
            "$deviceInfo\n\n\n\n==================    \n\n$message \n\n\n$date");
    try {
      var response =
          await _client.post("bot$botToken/sendMessage", data: data.toJson());
      if (response.isSuccessful) onSuccessSync?.call();
    } catch (e) {
      cacheIt.call(data, deviceInfo);
    }
  }

  TelegramBotSender({
    required this.botToken,
    required this.chatId,
  });
}
