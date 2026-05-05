import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('com.utd/native');

  Future<int> getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      return result;
    } on PlatformException catch (e) {
      debugPrint("Error battery: ${e.message}");
      return -1;
    }
  }

  Future<void> showNativeToast(String message) async {
    try{
      await platform.invokeMethod('showToast', {
        "message": message,
      });
    } on PlatformException catch (e) {
      debugPrint("Error toast: ${e.message}");
    }
  }
}
