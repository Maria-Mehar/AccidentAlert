import 'dart:ui';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Map<String, dynamic>? currentNotification; // null = no accident yet

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
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
                const SizedBox(height: 45),

                Center(
                  child: Text(
                    "Notifications",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.6),
                          offset: const Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: currentNotification == null
                    ? _buildEmptyState()
                    : _buildAccidentNotification(currentNotification!),
              ),

              // Test button to simulate notification
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: _glassButton(
                  text: "Simulate Notification",
                  onTap: _addTestNotification,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------- EMPTY STATE -------------------
  Widget _buildEmptyState() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.notifications_none, size: 80, color: Colors.white),
                SizedBox(height: 15),
                Text(
                  "No Notifications Yet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Stay tuned for real-time alerts.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------- ACCIDENT NOTIFICATION -------------------
  Widget _buildAccidentNotification(Map<String, dynamic> notification) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning, size: 80, color: Colors.redAccent),
                const SizedBox(height: 15),
                Text(
                  "Accident detected at ${notification["time"]} near ${notification["location"]}.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Emergency contact has been notified.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------- GLASS BUTTON -------------------
  Widget _glassButton({required String text, required VoidCallback onTap}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ------------------- ADD TEST NOTIFICATION -------------------
  void _addTestNotification() {
    final newNotification = {"time": "04:23 PM", "location": "F-10 Markaz"};

    setState(() {
      currentNotification = newNotification;
    });
  }
}
