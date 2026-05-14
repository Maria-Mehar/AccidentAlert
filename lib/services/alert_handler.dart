import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:AcciSense/screens/alert_screen.dart';
class AlertHandler {
  static bool _isAlertOpen = false;

  // Day 1: Listen for accidents in real-time
  static void listenForAccidents(BuildContext context) {
    FirebaseFirestore.instance
        .collection('accidents')
        .snapshots()
        .listen((snapshot) {
          if (snapshot.docs.isNotEmpty && !_isAlertOpen) {
            final doc = snapshot.docs.first;
            
            // Is flag ka maqsad ye hai ke ek sath 10 screens na khul jayein
            _isAlertOpen = true;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AlertScreen(docId: doc.id, data: doc.data()),
                 builder: (_) => AlertScreen( docId: doc.id,  data: doc.data() as Map<String, dynamic>
                 )
              ),
            ).then((_) {
              _isAlertOpen = false; // Screen close hone par wapas false
            });
          }
        });
  }
} // Screen import ki

            