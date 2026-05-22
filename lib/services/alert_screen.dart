
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AlertScreen extends StatefulWidget {
  final String? docId;
  final Map<String, dynamic>? data;

  const AlertScreen({super.key, this.docId, this.data});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  int seconds = 10;
  Timer? timer;

  String locationText = "Fetching location...";

  bool alertCancelled = false;
  bool alertSent = false;

  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _getLocation();
    startCountdown();
  }

  // 📍 LOCATION FETCH
  Future<void> _getLocation() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) {
        setState(() {
          locationText = "Lat: ${pos.latitude}, Lng: ${pos.longitude}";
        });

        if (widget.docId != null && uid != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('accidents')
              .doc(widget.docId)
              .update({'latitude': pos.latitude, 'longitude': pos.longitude});
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          locationText = "Location unavailable";
        });
      }
    }
  }

  // ⏳ COUNTDOWN TIMER
  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;

      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        t.cancel();
        if (!alertCancelled && !alertSent) {
          sendAutoAlert();
        }
      }
    });
  }

  // 🚨 AUTO SEND ALERT
  void sendAutoAlert() {
    if (alertCancelled || alertSent) return;
    _updateStatus('auto_sent');
    setState(() => alertSent = true);
  }

  // ❌ CANCEL ACTION
  void cancelAlert() {
    timer?.cancel();
    _updateStatus('cancelled');
    setState(() {
      alertCancelled = true;
      seconds = 0;
    });

    Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.pop(context),
    ); // 👈 close screen
  }

  // ✅ CONFIRM ACTION
  void confirmAlert() {
    timer?.cancel();
    _updateStatus('confirmed');
    setState(() {
      alertSent = true;
      seconds = 0;
    });

    Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.pop(context),
    ); // 👈 close screen
  }

  void _updateStatus(String status) {
    if (widget.docId != null && uid != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('accidents')
          .doc(widget.docId)
          .update({'status': status});
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🌄 Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(color: Colors.black.withOpacity(0.35)),

          SafeArea(
            child: Column(
              children: [
                // 🔙 Back Button
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // 📦 MAIN CARD
                Expanded(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.25),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // 🚨 ICON
                              Icon(
                                alertCancelled
                                    ? Icons.check_circle
                                    : Icons.warning,
                                size: 80,
                                color: alertCancelled
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),

                              const SizedBox(height: 20),

                              // 📝 TEXT
                              Text(
                                alertCancelled
                                    ? "Alert Cancelled"
                                    : alertSent
                                    ? "Alert Sent!"
                                    : "Sending alert in $seconds sec...",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),

                              const SizedBox(height: 15),

                              // 📍 LOCATION
                              Text(
                                locationText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),

                              const SizedBox(height: 30),

                              // 🔘 BUTTONS
                              if (!alertCancelled && !alertSent)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // ❌ CANCEL
                                    ElevatedButton(
                                      onPressed: cancelAlert,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey
                                            .withOpacity(0.7),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                          horizontal: 20,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),

                                    // ✅ CONFIRM
                                    ElevatedButton(
                                      onPressed: confirmAlert,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                          horizontal: 20,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),

                              // 🔒 AFTER STATE
                              if (alertCancelled || alertSent)
                                const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}