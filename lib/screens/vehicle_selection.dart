import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:accident_alert/navigation/main_layout.dart';

class VehicleSelectionScreen extends StatefulWidget {
  final bool fromSettings;

  const VehicleSelectionScreen({super.key, this.fromSettings = false});

  @override
  State<VehicleSelectionScreen> createState() => _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState extends State<VehicleSelectionScreen> {
  String selectedVehicle = 'Car';

  // ✅ Controllers for text fields
  final TextEditingController driverNameController = TextEditingController();
  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final List<String> vehicles = ['Car', 'Bike', 'Bus', 'Truck'];

  // ✅ Memory clean karne ke liye dispose method
  @override
  void dispose() {
    driverNameController.dispose();
    vehicleNumberController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark Overlay
          Container(color: Colors.black.withOpacity(0.45)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Vehicle Selection",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Add driver, vehicle & location details",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 25),

                  // ✅ Main Input Card
                  glassCard(
                    child: Column(
                      children: [
                        TextField(
                          cursorColor: Colors.redAccent,
                          controller: driverNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: inputDecoration("Driver Name"),
                        ),
                        const SizedBox(height: 15),

                        DropdownButtonFormField<String>(
                          initialValue: selectedVehicle,
                          dropdownColor: Colors.black87,
                          items: vehicles
                              .map(
                                (v) => DropdownMenuItem(
                                  value: v,
                                  child: Text(
                                    v,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() => selectedVehicle = value!);
                          },
                          decoration: inputDecoration("Vehicle Type"),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 15),

                        TextField(
                          controller: vehicleNumberController,
                          cursorColor: Colors.redAccent,
                          style: const TextStyle(color: Colors.white),
                          decoration: inputDecoration(
                            "Vehicle Number (e.g. LEA-1234)",
                          ),
                        ),
                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent.withOpacity(
                                0.8,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              if (driverNameController.text.isEmpty ||
                                  vehicleNumberController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please fill all fields"),
                                  ),
                                );
                                return;
                              }

                              if (widget.fromSettings) {
                                Navigator.pop(context);
                              } else {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainLayout(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                            child: const Text(
                              "Save Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  // ✅ Glassmorphism Card Widget
  Widget glassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: child,
        ),
      ),
    );
  }

  // ✅ Input Decoration Helper
  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }
}
