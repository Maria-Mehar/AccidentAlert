import 'dart:ui';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _fieldsGroup(context),

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
                const SizedBox(height: 100),
                _headerText(),

                const Spacer(flex: 1),

                _fieldsGroup(context),

                const Spacer(flex: 2),
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
                  "Already have an account? ",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Login",
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

  Widget _headerText() {
    return const Column(
      children: [
        Text(
          "Create Account",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Fill in the details below",
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
        const SizedBox(height: 12),
        _glassInputCard(
          child: TextField(
            cursorColor: Colors.redAccent,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Email", Icons.email),
          ),
        ),
        const SizedBox(height: 12),
        _glassInputCard(
          child: TextField(
            cursorColor: Colors.redAccent,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: _inputDecoration("Password", Icons.lock),
          ),
        ),
        const SizedBox(height: 12),
        _glassInputCard(
          child: TextField(
            cursorColor: Colors.redAccent,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: _inputDecoration("Confirm Password", Icons.lock),
          ),
        ),
        const SizedBox(height: 16),
        _glassInputCard(
          child: _signupButton(context),
          color: Colors.amber.withOpacity(0.3),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text("Or", style: TextStyle(color: Colors.white70)),
        ),
        const SizedBox(height: 16),
        _glassInputCard(
          child: _googleButton(),
          color: Colors.white.withOpacity(0.15),
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

  Widget _signupButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Signup logic

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
          "Sign Up",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _googleButton() {
    return TextButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_signup/google.png'),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 18),
          const Text(
            "Sign In with Google",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
