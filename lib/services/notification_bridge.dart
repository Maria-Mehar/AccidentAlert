Day 4: notification_bridge.dart
import 'package:flutter/services.dart';

class NotificationBridge {
  // Ye channel name Android side se match hona chahiye
  static const platform = MethodChannel('accident_channel');

  static Future<void> showNotification(String docId) async {
    try {
      // Native side (Java/Kotlin) ko trigger karna
      await platform.invokeMethod('showNotification', {"docId": docId});
    } catch (e) {
      print("Error triggering native notification: $e");
    }
  }
}