import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  Future<String> getDeviceInfo() async {
    String info = "";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      androidInfo.data.forEach((key, value) {
        info += "[$key]  $value\n";
      });
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      iosInfo.data.forEach((key, value) {
        info += "[$key]  $value\n";
      });
    }
    if (Platform.isWindows) {
      WindowsDeviceInfo windowsDeviceInfo = await deviceInfo.windowsInfo;
      windowsDeviceInfo.data.forEach((key, value) {
        info += "[$key]  $value\n";
      });
    }
    return info;
  }
}
