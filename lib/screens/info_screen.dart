import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:accident_alert/screens/notification_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.45)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                        "Maria Mehar 👋",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Welcome here",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),

                  const SizedBox(height: 10),

                  glassCard(
                    const SizedBox(height: 10),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Vehicle Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Divider(color: Colors.white54),
                        Text(
                          "Vehicle: Car",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "Number: LEA-1234",
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "GPS: ON",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  // Center(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => const NotificationScreen(),
                  //         ),
                  //       );
                  //     },
                  //     child: Container(
                  //       width: 160,
                  //       height: 160,
                  //       decoration: BoxDecoration(
                  //         color: Colors.redAccent,
                  //         shape: BoxShape.circle,
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.redAccent.withOpacity(0.5),
                  //             blurRadius: 30,
                  //             spreadRadius: 5,
                  //           ),
                  //         ],
                  //       ),
                  //       child: const Center(
                  //         child: Text(
                  //           "SOS",
                  //           style: TextStyle(
                  //             fontSize: 40,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 15),
                  // const Center(
                  //   child: Text(
                  //     "Press for Emergency",
                  //     style: TextStyle(color: Colors.white70),
                  //   ),
                  // ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget glassCard(SizedBox sizedBox, {required Widget child, double? height}) {
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
}
