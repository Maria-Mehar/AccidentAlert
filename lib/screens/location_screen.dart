import 'dart:ui';
import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Track & update your current position",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),

                const SizedBox(height: 25),

                glassCard(
                  child: Row(
                    children: [
                      Icon(
                        Icons.my_location,
                        color: Colors.blue.shade300,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Current Location\nTap to refresh",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Use My Location",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Map Preview",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                glassCard(
                  child: SizedBox(
                    height: 180,
                    child: Center(
                      child: Icon(
                        Icons.map,
                        color: Colors.white.withOpacity(0.25),
                        size: 70,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Nearby Accident Alerts",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                glassCard(
                  child: alertTile(
                    icon: Icons.error,
                    color: Colors.red.shade300,
                    title: "Accident near Shahrah-e-Faisal",
                    time: "5 min ago",
                  ),
                ),
                const SizedBox(height: 15),

                glassCard(
                  child: alertTile(
                    icon: Icons.warning_amber_rounded,
                    color: Colors.orange.shade300,
                    title: "Emergency in Gulshan Area",
                    time: "12 min ago",
                  ),
                ),
                const SizedBox(height: 15),

                glassCard(
                  child: alertTile(
                    icon: Icons.traffic,
                    color: Colors.yellow.shade300,
                    title: "Traffic Jam due to incident",
                    time: "20 min ago",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget glassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(20),
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

  Widget alertTile({
    required IconData icon,
    required Color color,
    required String title,
    required String time,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Text(time, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
