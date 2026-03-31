import 'dart:ui';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'package:accident_alert/navigation/main_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ✅ Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ✅ Login Function
  Future<void> loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Success → Move to MainLayout
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainLayout()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Login failed";
      if (e.code == 'user-not-found') {
        message = "No user found with this email";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Keyboard safety fix
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/auth.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey[900]),
            ),
          ),

          // Dark overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),

          // ✅ Scrollable Content (No Overflow)
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 80),
                _welcomeText(),

                const SizedBox(height: 60), // Space before fields
                _fieldsGroup(context),

                const SizedBox(height: 10),
                _forgotPassword(context),

                const SizedBox(height: 40),
                _signupCTA(),
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
        SizedBox(height: 10),
        Text(
          "Enter your credentials to login",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

  // Group Email, Password, Login button
  Widget _fieldsGroup(BuildContext context) {
    return Column(
      children: [
        _glassInputCard(
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Email", Icons.email),
          ),
        ),
        const SizedBox(height: 16),
        _glassInputCard(
          child: TextField(
            controller: passwordController,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: _inputDecoration("Password", Icons.lock),
          ),
        ),
        const SizedBox(height: 25),

        // ✅ Login Button with same Width and Round corners
        _glassInputCard(
          color: Colors.amber.withOpacity(0.5),
          child: InkWell(
            onTap: loginUser,
            borderRadius: BorderRadius.circular(30),
            child: const Center(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ✅ Fixed Glass Card for all (Buttons & Fields)
  Widget _glassInputCard({required Widget child, Color? color}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: child,
          ),
        ),
      ),
    );
  }

  // Input Decoration
  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white60),
      prefixIcon: Icon(icon, color: Colors.white70),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
    );
  }

  // Forgot Password
  Widget _forgotPassword(context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          // Add forgot password logic here
        },
        child: const Text(
          "Forgot password?",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  // Signup CTA
  Widget _signupCTA() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
