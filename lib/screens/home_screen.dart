import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. Firebase user fetch karna
  final User? currentUser = FirebaseAuth.instance.currentUser;
  late String displayName;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  // 2. Name handle karne ka logic
  void _initializeUser() {
    if (currentUser != null) {
      // Pehle check karein ke kya displayName mojood hai
      if (currentUser!.displayName != null &&
          currentUser!.displayName!.isNotEmpty) {
        displayName = currentUser!.displayName!;
      }
      // Agar name null hai (jesa apka case hai), toh email se name nikalein
      else if (currentUser!.email != null) {
        displayName = currentUser!.email!.split(
          '@',
        )[0]; // e.g. maria@gmail.com -> maria
        // Pehla letter capital karne ke liye (optional):
        displayName = displayName[0].toUpperCase() + displayName.substring(1);
      } else {
        displayName = "User";
      }
    } else {
      displayName = "Guest";
    }
  }

  final List<Map<String, dynamic>> modules = [
    {"icon": Icons.sensors, "label": "Accelerometer", "status": "ON"},
    {"icon": Icons.vibration, "label": "Vibration", "status": "ON"},
    {"icon": Icons.gps_fixed, "label": "GPS", "status": "Tracking"},
    {"icon": Icons.wifi, "label": "Network", "status": "Connected"},
  ];

  void _sendSOSAlert(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Emergency alert sent to ambulance and registered contacts!",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade800,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.45)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Updated Text with Dynamic Name
                  Text(
                    "$displayName 👋",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Welcome back to AcciSense",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 22),

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
                  const SizedBox(height: 35),

                  Center(
                    child: GestureDetector(
                      onTap: () => _sendSOSAlert(context),
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red.shade600, Colors.red.shade900],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.7),
                            width: 6,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.8),
                              blurRadius: 45,
                              spreadRadius: 15,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.emergency_share,
                                color: Colors.white,
                                size: 35,
                              ),
                              Text(
                                "SOS",
                                style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 45),

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
                            width: screenWidth * 0.38,
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
                  const SizedBox(height: 25),

                  fullWidthInfoCard(
                    icon: Icons.location_on_outlined,
                    text: "Location: Gujranwala",
                  ),
                  fullWidthInfoCard(
                    icon: Icons.car_crash_outlined,
                    text: "Auto Detection: Enabled",
                  ),
                  fullWidthInfoCard(
                    icon: Icons.battery_charging_full,
                    text: "Battery Level: 85%",
                  ),
                  fullWidthInfoCard(
                    icon: Icons.notifications_active_outlined,
                    text: "Last Alert: No Recent Incident",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
