import 'dart:ui';
import 'package:flutter/material.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/auth.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(color: Colors.black.withOpacity(0.4)),

          Positioned.fill(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: _welcomeText(),
                ),

                const Spacer(flex: 2),

                _fieldsGroup(context),

                const Spacer(flex: 1),

                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.3),
                  child: _forgotPassword(context),
                ),
              ],
            ),
          ),

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

  Widget _fieldsGroup(BuildContext context) {
    return Column(
      children: [
        _glassInputCard(
          child: TextField(
            cursorColor: Colors.redAccent,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Username", Icons.person),
          ),
        ),
        const SizedBox(height: 16),

        _glassInputCard(
          child: TextField(
            cursorColor: Colors.redAccent,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: _inputDecoration("Password", Icons.lock),
          ),
        ),
        const SizedBox(height: 16),

        _glassInputCard(
          child: _loginButton(context),
          color: Colors.amber.withOpacity(0.3),
        ),
      ],
    );
  }

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

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white),
      border: InputBorder.none,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
    );
  }

  Widget _loginButton(context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/vehicle');
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
