import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:AcciSense/screens/alert_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:AcciSense/services/notification_bridge.dart';

class AlertHandler {
  static bool _isAlertOpen = false;

  static void listenForAccidents(BuildContext context) {
    FirebaseFirestore.instance
        .collection('accidents')
        // .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .where('status', isEqualTo: 'active')
        .snapshots()
        .listen((snapshot) {
          print("🔥 SNAPSHOT: ${snapshot.docs.length}");
          if (snapshot.docs.isNotEmpty && !_isAlertOpen) {
            final doc = snapshot.docs.first;

            print("🔥 DOC ID: ${doc.id}");

            _isAlertOpen = true;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AlertScreen(docId: doc.id, data: doc.data()),
              ),
            ).then((_) {
              _isAlertOpen = false;
            });
            NotificationBridge.showNotification(doc.id);
          }
        });
  }
}