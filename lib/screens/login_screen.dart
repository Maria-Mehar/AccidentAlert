import 'dart:ui';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'package:accident_alert/navigation/main_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/auth.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark overlay
          Container(color: Colors.black.withOpacity(0.4)),

          // Stack layout for proportional positioning
          Positioned.fill(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: _welcomeText(),
                ),

                // Spacer to push fields down
                const Spacer(flex: 2),

                // Username, Password, Login button
                _fieldsGroup(context),

                const Spacer(flex: 1),

                // Forgot Password
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.3),
                  child: _forgotPassword(context),
                ),
              ],
            ),
          ),

          // Signup CTA at bottom
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Welcome Text
  Widget _welcomeText() {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Enter your credentials to login",
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  // Group Username, Password, Login button
  Widget _fieldsGroup(BuildContext context) {
    return Column(
      children: [
        // Username Card
        _glassInputCard(
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Username", Icons.person),
          ),
        ),
        const SizedBox(height: 16),

        // Password Card
        _glassInputCard(
          child: TextField(
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: _inputDecoration("Password", Icons.lock),
          ),
        ),
        const SizedBox(height: 16),

        // Login Button
        _glassInputCard(
          child: _loginButton(context),
          color: Colors.amber.withOpacity(0.3),
        ),
      ],
    );
  }

  // Glass Card
  Widget _glassInputCard({required Widget child, Color? color}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 60,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }

  // Input Decoration with proper alignment
  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white),
      border: InputBorder.none,
      isDense: true, // vertical center
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
      ), // tweak if needed
    );
  }

  // Login Button
  Widget _loginButton(context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainLayout()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: const Center(
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Forgot Password
  Widget _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
