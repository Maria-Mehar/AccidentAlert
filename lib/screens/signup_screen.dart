import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; // ✅ Naya Import

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // ✅ Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // ✅ Google Sign-In Function (Naya Function)
  Future<void> signInWithGoogle() async {
    try {
      print("Google Sign-In process started...");

      // 1. Google Popup show karein
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        print("Google Sign-In cancelled by user");
        return;
      }

      // 2. Auth details lein
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      // 3. Firebase Credential banayein
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Firebase mein login karein
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      print("Google Success: ${userCredential.user?.displayName}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome ${userCredential.user?.displayName}")),
      );

      // Success ke baad Login ya Home screen par bhej dein
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      print("GOOGLE ERROR: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Google Sign-In failed: $e")));
    }
  }

  // ✅ Purana Signup Function (Wese hi rakha hai)
  Future<void> signupUser() async {
    print("Signup process started...");
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      print("Validation Failed: Empty fields");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter a valid email")));
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      print(
        "Attempting to talk to Firebase with: ${emailController.text.trim()}",
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      print("Firebase Success: ${userCredential.user?.uid}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      print("FIREBASE ERROR DETECTED: ${e.code} - ${e.message}");

      String message = "Signup failed";
      if (e.code == 'email-already-in-use') {
        message = "Email already in use";
      } else if (e.code == 'weak-password') {
        message = "Password should be at least 6 characters";
      } else if (e.code == 'network-request-failed') {
        message = "Check your internet connection";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      print("UNKNOWN ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/auth.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey[900]),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 60),
                _headerText(),
                const SizedBox(height: 30),
                _fieldsGroup(),
                const SizedBox(height: 20),
                _bottomLink(),
                const SizedBox(height: 20),
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

  Widget _fieldsGroup() {
    return Column(
      children: [
        _glassInputCard(
          child: TextField(
            controller: usernameController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Username", Icons.person),
          ),
        ),
        const SizedBox(height: 12),
        _glassInputCard(
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Email", Icons.email),
          ),
        ),
        const SizedBox(height: 12),
        _glassInputCard(
          child: TextField(
            controller: passwordController,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: _inputDecoration("Password", Icons.lock),
          ),
        ),
        const SizedBox(height: 12),
        _glassInputCard(
          child: TextField(
            controller: confirmPasswordController,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: _inputDecoration("Confirm Password", Icons.lock),
          ),
        ),
        const SizedBox(height: 25),
        _glassInputCard(
          child: _signupButton(),
          color: Colors.amber.withOpacity(0.5),
        ),
        const SizedBox(height: 16),
        const Text("Or", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 16),
        _glassInputCard(
          child: _googleButton(), // Is button par function ab active hai
          color: Colors.white.withOpacity(0.1),
        ),
      ],
    );
  }

  Widget _bottomLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _glassInputCard({required Widget child, Color? color}) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color ?? Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: child,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white60, fontSize: 15),
      prefixIcon: Icon(icon, color: Colors.white70),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
    );
  }

  Widget _signupButton() {
    return InkWell(
      onTap: signupUser,
      child: const Center(
        child: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _googleButton() {
    return InkWell(
      onTap: signInWithGoogle, // ✅ Ab ye link ho gaya hai
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/login_signup/google.png',
            height: 25,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.g_mobiledata, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 12),
          const Text(
            "Sign In with Google",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
