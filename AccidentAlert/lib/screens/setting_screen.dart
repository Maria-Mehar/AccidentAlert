import 'dart:ui';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Dark overlay
          Container(color: Colors.black.withOpacity(0.35)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 🔥 CENTERED SETTINGS TITLE
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

                  /// EMERGENCY CONTACTS
                  glassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitle("EMERGENCY CONTACTS"),
                        navTile("Manage Contacts"),
                        navTile("Edit Emergency Message"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// DETECTION SETTINGS
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

                  /// ALERT OPTIONS
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
                          onChanged: (val) => setState(() => soundAlert = val),
                        ),
                        SwitchListTile(
                          title: const Text(
                            'Vibration',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: vibration,
                          onChanged: (val) => setState(() => vibration = val),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// LOCATION
                  glassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitle("LOCATION"),
                        navTile("Update Home Location"),
                        navTile("Privacy Policy"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ACCOUNT
                  glassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitle("ACCOUNT"),
                        navTile("Change Password"),
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

  /// Glass Card
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

  /// Section Title
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

  /// Navigation Tile
  Widget navTile(String title) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {},
    );
  }
}
