import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  int seconds = 10;
  Timer? timer;
  String locationText = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _getLocation();
    startCountdown();
  }

  Future<void> _getLocation() async {
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      locationText = "Lat: ${pos.latitude}, Lng: ${pos.longitude}";
    });
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        t.cancel();
        if (!alertCancelled) {
          sendAlert();
        }
      }
    });
  }

  Future<void> sendAlert() async {
    if (alertCancelled) return; // agar cancel hua ho toh stop

    List<String> recipients = ["+923001234567"];
    String message = "🚨 Accident Detected!\nLocation: $locationText";

    try {
      await sendSMS(message: message, recipients: recipients);
    } catch (e) {
      print("SMS Failed: $e");
    }

    setState(() {
      alertSent = true;
    });
  }

  bool alertCancelled = false;
  bool alertSent = false;

  void cancelAlert() {
    timer?.cancel();

    setState(() {
      alertCancelled = true;
      seconds = 0;
    });
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
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark overlay
          Container(color: Colors.black.withOpacity(0.35)),

          SafeArea(
            child: Column(
              children: [
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

                              Text(
                                alertCancelled
                                    ? "Alert Cancelled"
                                    : alertSent
                                    ? "Alert Sent!"
                                    : "Sending alert in $seconds sec...",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(height: 15),

                              const SizedBox(height: 15),
                              Text(
                                locationText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 25),

                              ElevatedButton(
                                onPressed: cancelAlert,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.withOpacity(0.7),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 30,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  alertSent || alertCancelled
                                      ? "Close Alert"
                                      : "Cancel Alert",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
