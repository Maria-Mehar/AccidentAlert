full code: notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationService {
  // 🔹 INIT
  static void init() {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        handleAction(response);
      },
    );
  }

  // 🔹 SHOW NOTIFICATION WITH BUTTONS
  static Future<void> showAlertNotification(String docId) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'alert_channel',
          'Accident Alerts',
          importance: Importance.max,
          priority: Priority.high,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction('confirm', 'Confirm'),
            AndroidNotificationAction('cancel', 'Cancel'),
          ],
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      docId.hashCode,
      '🚨 Accident Detected!',
      'Are you safe?',
      details,
      payload: docId,
    );
  }

  // 🔹 HANDLE BUTTON CLICK
  static void handleAction(NotificationResponse response) {
    final String? docId = response.payload;

    if (docId == null || docId.isEmpty) return;

    final docRef = FirebaseFirestore.instance
        .collection('accidents')
        .doc(docId);

    if (response.actionId == 'confirm') {
      docRef.update({'status': 'confirmed'});
    }

    if (response.actionId == 'cancel') {
      docRef.update({'status': 'cancelled'});
    }
  }
}