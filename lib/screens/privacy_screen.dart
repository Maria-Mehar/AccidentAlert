import 'dart:ui';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. Background Image (Wahi jo baaqi screens mein hai)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Dark Overlay
          Container(color: Colors.black.withOpacity(0.6)),

          // 3. Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  // Custom Header (Back Arrow + Title)
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "Privacy Policy",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Glass Card for Policy Text
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _policyHeader("Last Updated: March 2026"),
                                const SizedBox(height: 20),

                                _policySection(
                                  "1. Data Collection",
                                  "Our app collects real-time location and motion sensor data (Accelerometer/Gyroscope) to detect accidents. This data is essential for the SOS feature to function.",
                                ),

                                _policySection(
                                  "2. Google Services",
                                  "We use Google Maps API to provide accurate location coordinates in your emergency alerts. Google may collect data according to their own privacy standards.",
                                ),

                                _policySection(
                                  "3. Firebase & Security",
                                  "We use Firebase for authentication and database management. Your personal data is encrypted and stored securely on Google's Firebase servers.",
                                ),

                                _policySection(
                                  "4. Emergency Contacts",
                                  "The app only accesses your contacts to allow you to select emergency recipients. We do not upload your entire contact list to any server.",
                                ),

                                _policySection(
                                  "5. Permissions",
                                  "You can revoke Location, SMS, and Contact permissions at any time through your device settings, but it will disable the core accident alert functionality.",
                                ),

                                const Divider(
                                  color: Colors.white24,
                                  height: 40,
                                ),

                                const Center(
                                  child: Text(
                                    "If you have any questions, contact us at:\nmariamehar@gmail.com",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
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
          ),
        ],
      ),
    );
  }

  // Helper widget for Section Titles
  Widget _policySection(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _policyHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white38,
        fontSize: 12,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
