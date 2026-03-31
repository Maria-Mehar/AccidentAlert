import 'dart:ui';
import 'package:flutter/material.dart';
import 'info_screen.dart';

import 'vehicle_selection.dart';
import 'contact_screen.dart';
import 'change_pasword.dart';
import 'edit_msg_screen.dart';
import 'privacy_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool automaticDetection = true;
  bool soundAlert = true;
  bool vibration = true;
  double sensitivity = 0.6;

  void _showLogoutWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
            backgroundColor: Colors.black.withOpacity(0.8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            title: Row(
              children: const [
                Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
                SizedBox(width: 10),
                Text("Logout Alert", style: TextStyle(color: Colors.white)),
              ],
            ),
            content: const Text(
              "Are you sure you want to logout? Automatic accident detection and emergency alerts will be disabled.",
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                child: const Text(
                  "Logout Anyway",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          Container(color: Colors.black.withOpacity(0.35)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  const Center(
                    child: Text(
                      "SETTINGS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.3,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  glassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitle("EMERGENCY CONTACTS"),
                        navTile(
                          "Manage Contacts",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ContactScreen(),
                              ),
                            );
                          },
                        ),
                        navTile(
                          "Edit Emergency Message",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const EditEmergencyMessageScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  glassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitle("DETECTION SETTINGS"),
                        SwitchListTile(
                          title: const Text(
                            'Automatic Detection',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: automaticDetection,
                          activeColor: Colors.redAccent,
                          activeTrackColor: Colors.redAccent.withOpacity(0.4),
                          onChanged: (val) =>
                              setState(() => automaticDetection = val),
                        ),
                        ListTile(
                          title: const Text(
                            'Sensitivity Level',
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Slider(
                            activeColor: Colors.redAccent,
                            inactiveColor: Colors.white30,
                            value: sensitivity,
                            onChanged: (val) =>
                                setState(() => sensitivity = val),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  glassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitle("ALERT OPTIONS"),
                        SwitchListTile(
                          title: const Text(
                            'Sound Alert',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: soundAlert,
                          activeColor: Colors.redAccent,
                          activeTrackColor: Colors.redAccent.withOpacity(0.4),
                          onChanged: (val) => setState(() => soundAlert = val),
                        ),
                        SwitchListTile(
                          title: const Text(
                            'Vibration',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: vibration,

                          activeColor: Colors.redAccent,
                          activeTrackColor: Colors.redAccent.withOpacity(0.4),
                          onChanged: (val) => setState(() => vibration = val),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  glassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitle("LOCATION"),
                        navTile(
                          "System Information",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const InfoScreen(),
                              ),
                            );
                          },
                        ),
                        navTile(
                          "Privacy Policy",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PrivacyPolicyScreen(), // Nayi screen ka name
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  glassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitle("ACCOUNT"),

                        navTile(
                          "Vehicle & Driver Details",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const VehicleSelectionScreen(
                                  fromSettings: true,
                                ),
                              ),
                            );
                          },
                        ),

                        navTile(
                          "Change Password",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ChangePasswordScreen(),
                              ),
                            );
                          },
                        ),

                        const Divider(color: Colors.white24, height: 30),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.logout_rounded,
                            color: Colors.redAccent,
                          ),
                          title: const Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: const Text(
                            "Stop all safety services",
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                          onTap: () => _showLogoutWarning(context),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget glassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget navTile(String title, {VoidCallback? onTap}) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: onTap ?? () {},
    );
  }
}
