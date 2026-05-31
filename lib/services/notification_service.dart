//Day 1: notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationService {
  // Day 1: Basic setup jo app band hone par bhi active rahay
  static void init() {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Button click logic hum Day 6 mein likhen gy
        print("Notification Clicked: ${response.payload}");
      },
    );
  }
}
//Day 2: notification_service.dart
// 🔹 Step 2: Show Notification with Buttons
  Future<void> showAlertNotification(String docId) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'alert_channel',
          'Accident Alerts',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true, // Lock screen par show karne ke liye
          actions: <AndroidNotificationAction>[
            // Confirm Button
            AndroidNotificationAction(
              'confirm', 
              'Confirm ✅', 
              showsUserInterface: true
            ),
            // Cancel Button
            AndroidNotificationAction(
              'cancel', 
              'Cancel ❌', 
              showsUserInterface: true
            ),
          ],
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      docId.hashCode,
      '🚨 Accident Detected!',
      'Are you safe? Please respond immediately.',
      details,
      payload: docId, // Ye ID hume batati hai kis accident ko update karna hai
    );
  }
 // Day 3: notification_service.dartimport 'package:cloud_firestore/cloud_firestore.dart';

  // 🔹 Step 3: Handle Button Clicks
  void handleAction(NotificationResponse response) {
    final String? docId = response.payload;
    if (docId == null || docId.isEmpty) return;

    final docRef = FirebaseFirestore.instance
        .collection('accidents')
        .doc(docId);

    // Agar user ne 'Confirm' dabaya
    if (response.actionId == 'confirm') {
      docRef.update({'status': 'confirmed'});
      print("Status updated to Confirmed from Background");
    }

    // Agar user ne 'Cancel' dabaya
    if (response.actionId == 'cancel') {
      docRef.update({'status': 'cancelled'});
      print("Status updated to Cancelled from Background");
    }
  }