import 'dart:ui';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> modules = [
    {"icon": Icons.sensors, "label": "Accelerometer", "status": "ON"},
    {"icon": Icons.vibration, "label": "Vibration", "status": "ON"},
    {"icon": Icons.gps_fixed, "label": "GPS", "status": "Tracking"},
    {"icon": Icons.wifi, "label": "Network", "status": "Connected"},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Background Image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Dark overlay
        Container(color: Colors.black.withOpacity(0.38)),

        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Name Text
                const Text(
                  "Maria Mehar 👋",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Welcome here",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 22),

                // ⭐ MAIN BIG HEADER CARD
                glassCard(
                  height: screenHeight * 0.28,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.shield_outlined,
                        size: 48,
                        color: Colors.white,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "System Activated",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Your system is fully operational.",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ⭐ SIDE-BY-SIDE MODULE CARDS
                SizedBox(
                  height: screenHeight * 0.22,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: modules.length,
                    itemBuilder: (context, index) {
                      final module = modules[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: SizedBox(
                          width: screenWidth * 0.38, // 2 visible clean
                          child: glassCard(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  module['icon'],
                                  color: Colors.white,
                                  size: 35,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  module['label'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  module['status'],
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // ⭐ FULL WIDTH CARDS (with icons)
                fullWidthInfoCard(
                  icon: Icons.location_on_outlined,
                  text: "Location: Gujranwala",
                ),
                fullWidthInfoCard(
                  icon: Icons.car_crash_outlined,
                  text: "Auto Detection: On",
                ),
                fullWidthInfoCard(
                  icon: Icons.battery_6_bar_outlined,
                  text: "Battery: 85%",
                ),
                fullWidthInfoCard(
                  icon: Icons.notifications_none,
                  text: "Last Alert: None",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ⭐ GLASS CARD REUSABLE WIDGET
  Widget glassCard({required Widget child, double? height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: child,
        ),
      ),
    );
  }

  // ⭐ FULL WIDTH INFO CARD WIDGET
  Widget fullWidthInfoCard({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: glassCard(
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
