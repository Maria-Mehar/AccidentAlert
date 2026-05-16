import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class AlertScreen extends StatefulWidget {
  final String? docId;
  final Map<String, dynamic>? data;

  const AlertScreen({super.key, this.docId, this.data});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
// State ke andar ye variables aur functions:
int seconds = 10;
Timer? timer;
bool alertSent = false;

@override
void initState() {
  super.initState();
  startCountdown();
}

void startCountdown() {
  timer = Timer.periodic(const Duration(seconds: 1), (t) {
    if (!mounted) return;
    if (seconds > 0) {
      setState(() => seconds--);
    } else {
      t.cancel();
      if (!alertSent) {
        sendAutoAlert();
      }
    }
  });
}

void sendAutoAlert() {
  _updateStatus('auto_sent');
  setState(() => alertSent = true);
}
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 🌄 Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark Overlay
          Container(color: Colors.black.withOpacity(0.35)),

          // 📦 Glass Card
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.25)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.warning, size: 80, color: Colors.redAccent),
                      const SizedBox(height: 20),
                      const Text(
                        "Accident Detected!",
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      // Yahan countdown aye ga (Day 4)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}