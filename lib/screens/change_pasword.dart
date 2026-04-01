import 'dart:ui';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _isOldObscured = true;
  bool _isNewObscured = true;
  bool _isConfirmObscured = true;

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

          Container(color: Colors.black.withOpacity(0.45)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text(
                          "Change Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    glassCard(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),

                          TextFormField(
                            controller: _oldPassController,
                            obscureText: _isOldObscured,
                            cursorColor: Colors.redAccent,
                            style: const TextStyle(color: Colors.white),
                            decoration: inputDecoration(
                              "Current Password",
                              Icons.lock_outline,
                              _isOldObscured,
                              () => setState(
                                () => _isOldObscured = !_isOldObscured,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          TextFormField(
                            controller: _newPassController,
                            obscureText: _isNewObscured,
                            cursorColor: Colors.redAccent,
                            style: const TextStyle(color: Colors.white),
                            decoration: inputDecoration(
                              "New Password",
                              Icons.vpn_key_outlined,
                              _isNewObscured,
                              () => setState(
                                () => _isNewObscured = !_isNewObscured,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          TextFormField(
                            controller: _confirmPassController,
                            obscureText: _isConfirmObscured,
                            cursorColor: Colors.redAccent,
                            style: const TextStyle(color: Colors.white),
                            decoration: inputDecoration(
                              "Confirm New Password",
                              Icons.check_circle_outline,
                              _isConfirmObscured,
                              () => setState(
                                () => _isConfirmObscured = !_isConfirmObscured,
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 5,
                              ),
                              onPressed: _handlePasswordUpdate,
                              child: const Text(
                                "UPDATE PASSWORD",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget glassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(20),
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

  InputDecoration inputDecoration(
    String label,
    IconData icon,
    bool isObscured,
    VoidCallback toggleVisibility,
  ) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      suffixIcon: IconButton(
        icon: Icon(
          isObscured ? Icons.visibility_off : Icons.visibility,
          color: Colors.white70,
        ),
        onPressed: toggleVisibility,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }

  void _handlePasswordUpdate() {
    if (_newPasswordIsValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Updated Successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  bool _newPasswordIsValid() {
    if (_oldPassController.text.isEmpty || _newPassController.text.isEmpty) {
      _showError("Fields cannot be empty");
      return false;
    }
    if (_newPassController.text != _confirmPassController.text) {
      _showError("Passwords do not match!");
      return false;
    }
    if (_newPassController.text.length < 6) {
      _showError("Password must be at least 6 characters");
      return false;
    }
    return true;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }
}
