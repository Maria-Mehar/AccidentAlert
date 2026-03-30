import 'dart:ui';
import 'package:flutter/material.dart';

class EditEmergencyMessageScreen extends StatefulWidget {
  const EditEmergencyMessageScreen({super.key});

  @override
  State<EditEmergencyMessageScreen> createState() =>
      _EditEmergencyMessageScreenState();
}

class _EditEmergencyMessageScreenState
    extends State<EditEmergencyMessageScreen> {
  // Controller for text message
  final TextEditingController _messageController = TextEditingController(
    text:
        "I've been in an accident at this location. Please send help immediately!",
  );

  // Toggle States
  bool _includeLocation = true;
  bool _highPriority = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home.jpg'), // Aapka image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Dark Overlay
          Container(color: Colors.black.withOpacity(0.55)),

          // 3. Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header Row (Arrow + Title) ---
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
                        "Emergency Message",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // --- Glass Card for Settings ---
                  Expanded(
                    child: SingleChildScrollView(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Custom Alert Message",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15),

                                // Text Input Field
                                TextField(
                                  controller: _messageController,
                                  maxLines: 5,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: "Type your message...",
                                    hintStyle: const TextStyle(
                                      color: Colors.white38,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.3),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Reset Button
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _messageController.text =
                                            "I've been in an accident. Please help!";
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.refresh,
                                      size: 16,
                                      color: Colors.blueAccent,
                                    ),
                                    label: const Text(
                                      "Reset to Default",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ),
                                ),

                                const Divider(
                                  color: Colors.white24,
                                  height: 30,
                                ),

                                // --- Toggle Options ---
                                _buildToggleOption(
                                  title: "Include Live Location",
                                  subtitle: "Attach Google Maps link",
                                  value: _includeLocation,
                                  onChanged: (val) =>
                                      setState(() => _includeLocation = val),
                                ),

                                const SizedBox(height: 15),

                                _buildToggleOption(
                                  title: "High Priority SMS",
                                  subtitle: "Override 'Do Not Disturb'",
                                  value: _highPriority,
                                  onChanged: (val) =>
                                      setState(() => _highPriority = val),
                                ),

                                const SizedBox(height: 20),

                                const Text(
                                  "Note: This message will be sent to all your emergency contacts immediately after an accident is detected.",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- Save Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Success Feedback
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Emergency message saved!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                      ),
                      child: const Text(
                        "SAVE CHANGES",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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

  // Helper function to build toggle rows easily
  Widget _buildToggleOption({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.redAccent,
          activeTrackColor: Colors.redAccent.withOpacity(0.4),
          inactiveThumbColor: Colors.white60,
        ),
      ],
    );
  }
}
