<<<<<<< Updated upstream

=======
// // import 'dart:ui';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:flutter/material.dart';
// // import 'login_screen.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class SignupScreen extends StatefulWidget {
// //   const SignupScreen({super.key});

// //   @override
// //   State<SignupScreen> createState() => _SignupScreenState();
// // }

// // class _SignupScreenState extends State<SignupScreen> {
// //   // ✅ 1. Tamam Controllers (Aapke original controllers)
// //   final TextEditingController usernameController = TextEditingController();
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //   final TextEditingController confirmPasswordController =
// //       TextEditingController();

// //   // ✅ 2. UI State Variables (Eye toggle aur Loading ke liye)
// //   bool _isPasswordVisible = false;
// //   bool _isConfirmPasswordVisible = false;
// //   bool _isLoading = false;

// //   final GoogleSignIn _googleSignIn = GoogleSignIn();

// //   // ✅ 3. Google Sign-In Function (Mukammal logic ke sath)
// //   Future<void> signInWithGoogle() async {
// //     try {
// //       print("Google Sign-In process started...");
// //       setState(() => _isLoading = true);

// //       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
// //       if (googleUser == null) {
// //         print("Google Sign-In cancelled by user");
// //         setState(() => _isLoading = false);
// //         return;
// //       }

// //       final GoogleSignInAuthentication googleAuth =
// //           await googleUser.authentication;
// //       final AuthCredential credential = GoogleAuthProvider.credential(
// //         accessToken: googleAuth.accessToken,
// //         idToken: googleAuth.idToken,
// //       );

// //       UserCredential userCredential = await FirebaseAuth.instance
// //           .signInWithCredential(credential);
// //       print("Google Success: ${userCredential.user?.displayName}");

// //       if (!mounted) return;

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Welcome ${userCredential.user?.displayName}")),
// //       );

// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (context) => const LoginScreen()),
// //       );
// //     } catch (e) {
// //       print("GOOGLE ERROR: $e");
// //       if (!mounted) return;
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text("Google Sign-In failed: $e")));
// //     } finally {
// //       if (mounted) setState(() => _isLoading = false);
// //     }
// //   }

// //   // ✅ 4. Full Validation & Signup Function (Aapka + Mera Mix Logic)
// //   Future<void> signupUser() async {
// //     print("Signup process started...");

// //     // Basic Empty Check
// //     if (usernameController.text.isEmpty ||
// //         emailController.text.isEmpty ||
// //         passwordController.text.isEmpty ||
// //         confirmPasswordController.text.isEmpty) {
// //       print("Validation Failed: Empty fields");
// //       _showSnackBar("Please fill all fields");
// //       return;
// //     }

// //     // Email Regex (Aapka original regex)
// //     RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
// //     if (!emailRegex.hasMatch(emailController.text.trim())) {
// //       _showSnackBar("Enter a valid email");
// //       return;
// //     }

// //     // Password Strength & Match (Aapki condition + Professional check)
// //     if (passwordController.text.length < 6) {
// //       _showSnackBar("Password should be at least 6 characters");
// //       return;
// //     }

// //     if (!RegExp(r'[0-9]').hasMatch(passwordController.text)) {
// //       _showSnackBar("Password must contain at least one number");
// //       return;
// //     }

// //     if (passwordController.text != confirmPasswordController.text) {
// //       _showSnackBar("Passwords do not match");
// //       return;
// //     }

// //     // --- Firebase Call ---
// //     setState(() => _isLoading = true);
// //     try {
// //       print(
// //         "Attempting to talk to Firebase with: ${emailController.text.trim()}",
// //       );

// //       UserCredential userCredential = await FirebaseAuth.instance
// //           .createUserWithEmailAndPassword(
// //             email: emailController.text.trim(),
// //             password: passwordController.text.trim(),
// //           );

// //       print("Firebase Success: ${userCredential.user?.uid}");

// //       if (!mounted) return;
// //       _showSnackBar("Account created successfully");

// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (context) => const LoginScreen()),
// //       );
// //     } on FirebaseAuthException catch (e) {
// //       print("FIREBASE ERROR DETECTED: ${e.code} - ${e.message}");

// //       // Aapke bataye hue specific error messages
// //       String message = "Signup failed";
// //       if (e.code == 'email-already-in-use') {
// //         message = "Email already in use";
// //       } else if (e.code == 'weak-password') {
// //         message = "Password should be at least 6 characters";
// //       } else if (e.code == 'network-request-failed') {
// //         message = "Check your internet connection";
// //       } else if (e.message != null) {
// //         message = e.message!;
// //       }

// //       _showSnackBar(message);
// //     } catch (e) {
// //       print("UNKNOWN ERROR: $e");
// //       _showSnackBar("An unexpected error occurred");
// //     } finally {
// //       if (mounted) setState(() => _isLoading = false);
// //     }
// //   }

// //   void _showSnackBar(String message) {
// //     ScaffoldMessenger.of(
// //       context,
// //     ).showSnackBar(SnackBar(content: Text(message)));
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       resizeToAvoidBottomInset: true,
// //       body: Stack(
// //         children: [
// //           // Background Image (Aapka original UI)
// //           Positioned.fill(
// //             child: Image.asset(
// //               "assets/images/auth.png",
// //               fit: BoxFit.cover,
// //               errorBuilder: (context, error, stackTrace) =>
// //                   Container(color: Colors.grey[900]),
// //             ),
// //           ),
// //           // Dark Overlay
// //           Positioned.fill(
// //             child: Container(color: Colors.black.withOpacity(0.5)),
// //           ),
// //           SafeArea(
// //             child: ListView(
// //               padding: const EdgeInsets.symmetric(horizontal: 20),
// //               children: [
// //                 const SizedBox(height: 60),
// //                 _headerText(),
// //                 const SizedBox(height: 30),
// //                 _fieldsGroup(),
// //                 const SizedBox(height: 20),
// //                 _bottomLink(),
// //                 const SizedBox(height: 20),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _headerText() {
// //     return const Column(
// //       children: [
// //         Text(
// //           "Create Account",
// //           style: TextStyle(
// //             fontSize: 34,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //           ),
// //         ),
// //         SizedBox(height: 10),
// //         Text(
// //           "Fill in the details below",
// //           style: TextStyle(color: Colors.white70),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _fieldsGroup() {
// //     return Column(
// //       children: [
// //         _glassInputCard(
// //           child: TextField(
// //             controller: usernameController,
// //             cursorColor: Colors.amber,
// //             textCapitalization: TextCapitalization.words,
// //             style: const TextStyle(color: Colors.white),
// //             decoration: _inputDecoration("Username", Icons.person),
// //           ),
// //         ),
// //         _glassInputCard(
// //           child: TextField(
// //             controller: emailController,
// //             cursorColor: Colors.amber,
// //             keyboardType: TextInputType.emailAddress,
// //             style: const TextStyle(color: Colors.white),
// //             decoration: _inputDecoration("Email", Icons.email),
// //           ),
// //         ),
// //         // ✅ Password with Eye Toggle
// //         _glassInputCard(
// //           child: TextField(
// //             controller: passwordController,
// //             cursorColor: Colors.amber,
// //             style: const TextStyle(color: Colors.white),
// //             obscureText: !_isPasswordVisible,
// //             decoration: _inputDecoration(
// //               "Password",
// //               Icons.lock,
// //               suffix: IconButton(
// //                 icon: Icon(
// //                   _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
// //                   color: Colors.white70,
// //                 ),
// //                 onPressed: () =>
// //                     setState(() => _isPasswordVisible = !_isPasswordVisible),
// //               ),
// //             ),
// //           ),
// //         ),
// //         // ✅ Confirm Password with Eye Toggle
// //         _glassInputCard(
// //           child: TextField(
// //             controller: confirmPasswordController,
// //             cursorColor: Colors.amber,
// //             style: const TextStyle(color: Colors.white),
// //             obscureText: !_isConfirmPasswordVisible,
// //             decoration: _inputDecoration(
// //               "Confirm Password",
// //               Icons.lock,
// //               suffix: IconButton(
// //                 icon: Icon(
// //                   _isConfirmPasswordVisible
// //                       ? Icons.visibility
// //                       : Icons.visibility_off,
// //                   color: Colors.white70,
// //                 ),
// //                 onPressed: () => setState(
// //                   () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 25),
// //         // ✅ Signup Button with Loading Spinner
// //         _glassInputCard(
// //           child: _isLoading
// //               ? const Center(
// //                   child: CircularProgressIndicator(color: Colors.white),
// //                 )
// //               : _signupButton(),
// //           color: Colors.amber.withOpacity(0.7),
// //         ),
// //         const SizedBox(height: 16),
// //         const Text("Or", style: TextStyle(color: Colors.white70)),
// //         const SizedBox(height: 16),
// //         // ✅ Google Button
// //         _glassInputCard(
// //           child: _googleButton(),
// //           color: Colors.white.withOpacity(0.15),
// //         ),
// //       ],
// //     );
// //   }

// //   // ✅ Glass UI with Backdrop Filter (Blur)
// //   Widget _glassInputCard({required Widget child, Color? color}) {
// //     return Container(
// //       margin: const EdgeInsets.symmetric(vertical: 8),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(30),
// //         child: BackdropFilter(
// //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //           child: Container(
// //             width: double.infinity,
// //             height: 60,
// //             decoration: BoxDecoration(
// //               color: color ?? Colors.white.withOpacity(0.2),
// //               borderRadius: BorderRadius.circular(30),
// //               border: Border.all(color: Colors.white.withOpacity(0.2)),
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 15),
// //               child: child,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   InputDecoration _inputDecoration(
// //     String hint,
// //     IconData icon, {
// //     Widget? suffix,
// //   }) {
// //     return InputDecoration(
// //       hintText: hint,
// //       hintStyle: const TextStyle(color: Colors.white70, fontSize: 14),
// //       prefixIcon: Icon(icon, color: Colors.white),
// //       suffixIcon: suffix,
// //       border: InputBorder.none,
// //       contentPadding: const EdgeInsets.symmetric(vertical: 18),
// //     );
// //   }

// //   Widget _signupButton() {
// //     return InkWell(
// //       onTap: signupUser,
// //       child: const Center(
// //         child: Text(
// //           "Sign Up",
// //           style: TextStyle(
// //             fontSize: 18,
// //             color: Colors.white,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _googleButton() {
// //     return InkWell(
// //       onTap: _isLoading ? null : signInWithGoogle,
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Image.asset(
// //             'assets/images/login_signup/google.png',
// //             height: 25,
// //             errorBuilder: (context, error, stackTrace) =>
// //                 const Icon(Icons.g_mobiledata, color: Colors.white, size: 30),
// //           ),
// //           const SizedBox(width: 12),
// //           const Text(
// //             "Sign Up with Google",
// //             style: TextStyle(fontSize: 16, color: Colors.white),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _bottomLink() {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         const Text(
// //           "Already have an account? ",
// //           style: TextStyle(color: Colors.white),
// //         ),
// //         GestureDetector(
// //           onTap: () => Navigator.pushReplacement(
// //             context,
// //             MaterialPageRoute(builder: (context) => const LoginScreen()),
// //           ),
// //           child: const Text(
// //             "Login",
// //             style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     usernameController.dispose();
// //     emailController.dispose();
// //     passwordController.dispose();
// //     confirmPasswordController.dispose();
// //     super.dispose();
// //   }
// // }

// // try
// import 'dart:ui';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/material.dart';
// import 'login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//   bool _isLoading = false;

//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   Future<void> signInWithGoogle() async {
//     try {
//       setState(() => _isLoading = true);
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         setState(() => _isLoading = false);
//         return;
//       }

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await FirebaseAuth.instance.signInWithCredential(credential);

//       if (!mounted) return;
//       _showSnackBar("Google login successful!");

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     } catch (e) {
//       if (!mounted) return;
//       _showSnackBar("Google Error: $e");
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   Future<void> signupUser() async {
//     if (emailController.text.isEmpty || passwordController.text.isEmpty) {
//       _showSnackBar("Please fill all fields");
//       return;
//     }

//     if (passwordController.text != confirmPasswordController.text) {
//       _showSnackBar("Passwords do not match");
//       return;
//     }

//     setState(() => _isLoading = true);
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );

//       if (!mounted) return;
//       _showSnackBar("Account Created!");

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     } on FirebaseAuthException catch (e) {
//       _showSnackBar(e.message ?? "Signup Failed");
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               "assets/images/auth.png",
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) =>
//                   Container(color: Colors.black),
//             ),
//           ),
//           Container(color: Colors.black.withOpacity(0.5)),
//           SafeArea(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               children: [
//                 const SizedBox(height: 50),
//                 const Text(
//                   "Create Account",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 34,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 _glassInputCard(
//                   child: TextField(
//                     controller: usernameController,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: _inputDecoration("Username", Icons.person),
//                   ),
//                 ),
//                 _glassInputCard(
//                   child: TextField(
//                     controller: emailController,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: _inputDecoration("Email", Icons.email),
//                   ),
//                 ),
//                 _glassInputCard(
//                   child: TextField(
//                     controller: passwordController,
//                     obscureText: !_isPasswordVisible,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: _inputDecoration(
//                       "Password",
//                       Icons.lock,
//                       suffix: IconButton(
//                         icon: Icon(
//                           _isPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: Colors.white70,
//                         ),
//                         onPressed: () => setState(
//                           () => _isPasswordVisible = !_isPasswordVisible,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 _glassInputCard(
//                   child: TextField(
//                     controller: confirmPasswordController,
//                     obscureText: !_isConfirmPasswordVisible,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: _inputDecoration(
//                       "Confirm Password",
//                       Icons.lock,
//                       suffix: IconButton(
//                         icon: Icon(
//                           _isConfirmPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: Colors.white70,
//                         ),
//                         onPressed: () => setState(
//                           () => _isConfirmPasswordVisible =
//                               !_isConfirmPasswordVisible,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 _isLoading
//                     ? const Center(
//                         child: CircularProgressIndicator(color: Colors.amber),
//                       )
//                     : _actionButton(
//                         "Sign Up",
//                         signupUser,
//                         Colors.amber.withOpacity(0.8),
//                       ),
//                 const SizedBox(height: 15),
//                 _actionButton(
//                   "Sign Up with Google",
//                   signInWithGoogle,
//                   Colors.white.withOpacity(0.2),
//                 ),
//                 const SizedBox(height: 20),
//                 _bottomLink(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _glassInputCard({required Widget child}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(color: Colors.white24),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
//         child: child,
//       ),
//     );
//   }

//   InputDecoration _inputDecoration(
//     String hint,
//     IconData icon, {
//     Widget? suffix,
//   }) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(color: Colors.white60),
//       prefixIcon: Icon(icon, color: Colors.white70),
//       suffixIcon: suffix,
//       border: InputBorder.none,
//     );
//   }

//   Widget _actionButton(String text, VoidCallback onTap, Color color) {
//     return ElevatedButton(
//       onPressed: onTap,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         minimumSize: const Size(double.infinity, 55),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(color: Colors.white, fontSize: 16),
//       ),
//     );
//   }

//   Widget _bottomLink() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           "Already have an account? ",
//           style: TextStyle(color: Colors.white70),
//         ),
//         GestureDetector(
//           onTap: () => Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const LoginScreen()),
//           ),
//           child: const Text(
//             "Login",
//             style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     usernameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }
// }

import 'package:google_sign_in/google_sign_in.dart'; // Ye line top par honi chahiye
// import 'package:google_sign_in/google_sign_in.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart'; // ✅ Check this import
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

// import 'package:google_sign_in/google_sign_in.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

<<<<<<< Updated upstream
  // ✅ Fix 1: Explicitly using named constructor if unnamed fails
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard(scopes: ['email']);
=======
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future<void> signInWithGoogle() async {
  //   try {
  //     setState(() => _isLoading = true);
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) {
  //       setState(() => _isLoading = false);
  //       return;
  //     }

  //     // final GoogleSignInAuthentication googleAuth =await googleUser.authentication;
  //     final GoogleSignInAuthentication googleAuth =
  //         googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     await FirebaseAuth.instance.signInWithCredential(credential);

  final GoogleSignIn _googleSignIn = GoogleSignIn();
>>>>>>> Stashed changes

  Future<void> signInWithGoogle() async {
    try {
      setState(() => _isLoading = true);

      // 2. Sign in call karein
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }

<<<<<<< Updated upstream
      // ✅ Fix 2: 'authentication' is a getter that returns a Future
      // So we MUST await it to get GoogleSignInAuthentication
      // final googleAuth = googleUser.authentication;

      // final AuthCredential credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );

      // 'await' zaroori hai kyunke ye Future return karta hai
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

=======
      // 3. YAHAN DHAYAN DEIN: Authentication ko 'await' lazmi karna hai
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 4. Credential create karein
>>>>>>> Stashed changes
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

<<<<<<< Updated upstream
      // final String? accessToken = googleAuth.accessToken;
      // final String? idToken = googleAuth.idToken;

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome ${userCredential.user?.displayName}")),
      );
=======
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;
      _showSnackBar("Google login successful!");
>>>>>>> Stashed changes

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
<<<<<<< Updated upstream
      debugPrint("GOOGLE ERROR: $e");
=======
>>>>>>> Stashed changes
      if (!mounted) return;
      _showSnackBar("Google Error: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

<<<<<<< Updated upstream
  // Signup with Email logic
  Future<void> signupUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showSnackBar("Please fill all fields");
      return;
    }
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!mounted) return;
=======
  // Future<void> signupUser() async {
  //   if (emailController.text.isEmpty || passwordController.text.isEmpty) {
  //     _showSnackBar("Please fill all fields");
  //     return;
  //   }

  //   if (passwordController.text != confirmPasswordController.text) {
  //     _showSnackBar("Passwords do not match");
  //     return;
  //   }

  //   setState(() => _isLoading = true);
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );

  //     if (!mounted) return;
  //     _showSnackBar("Account Created!");

  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const LoginScreen()),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     _showSnackBar(e.message ?? "Signup Failed");
  //   } finally {
  //     if (mounted) setState(() => _isLoading = false);
  //   }
  // }

  Future<void> signupUser() async {
    // 1. Validation (Check karein ke koi field khali na ho)
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        usernameController.text.isEmpty) {
      _showSnackBar("Please fill all fields");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showSnackBar("Passwords do not match");
      return;
    }

    setState(() => _isLoading = true);
    try {
      // 2. Firebase User Create karein
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      // 3. User ka Display Name (Username) set karein
      await userCredential.user?.updateDisplayName(
        usernameController.text.trim(),
      );

      if (!mounted) return;
      _showSnackBar("Account Created Successfully!");

      // 4. Success ke baad Login screen par bhej dein
>>>>>>> Stashed changes
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
<<<<<<< Updated upstream
      _showSnackBar(e.message ?? "Signup failed");
=======
      // Specific Firebase Errors handle karein
      String errorMessage = "Signup Failed";
      if (e.code == 'email-already-in-use') {
        errorMessage = "This email is already in use.";
      } else if (e.code == 'weak-password') {
        errorMessage = "Password is too weak (at least 6 chars).";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is badly formatted.";
      } else {
        errorMessage = e.message ?? "An error occurred.";
      }
      _showSnackBar(errorMessage);
    } catch (e) {
      _showSnackBar("An unexpected error occurred: $e");
>>>>>>> Stashed changes
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/auth.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.black),
            ),
          ),
<<<<<<< Updated upstream
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.5)),
          ),
=======
          Container(color: Colors.black.withOpacity(0.5)),
>>>>>>> Stashed changes
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
<<<<<<< Updated upstream
                const SizedBox(height: 60),
=======
                const SizedBox(height: 50),
>>>>>>> Stashed changes
                const Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                _glassInputCard(
                  child: TextField(
                    controller: usernameController,
                    style: const TextStyle(color: Colors.white),
<<<<<<< Updated upstream
                    decoration: const InputDecoration(
                      hintText: "Username",
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                      border: InputBorder.none,
                    ),
=======
                    decoration: _inputDecoration("Username", Icons.person),
>>>>>>> Stashed changes
                  ),
                ),
                _glassInputCard(
                  child: TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
<<<<<<< Updated upstream
                    decoration: const InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                      border: InputBorder.none,
                    ),
=======
                    decoration: _inputDecoration("Email", Icons.email),
>>>>>>> Stashed changes
                  ),
                ),
                _glassInputCard(
                  child: TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    style: const TextStyle(color: Colors.white),
<<<<<<< Updated upstream
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
=======
                    decoration: _inputDecoration(
                      "Password",
                      Icons.lock,
                      suffix: IconButton(
>>>>>>> Stashed changes
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                        onPressed: () => setState(
                          () => _isPasswordVisible = !_isPasswordVisible,
                        ),
                      ),
                    ),
                  ),
                ),
<<<<<<< Updated upstream
                const SizedBox(height: 25),
=======
                _glassInputCard(
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputDecoration(
                      "Confirm Password",
                      Icons.lock,
                      suffix: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                        onPressed: () => setState(
                          () => _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
>>>>>>> Stashed changes
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.amber),
                      )
<<<<<<< Updated upstream
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(double.infinity, 55),
                        ),
                        onPressed: signupUser,
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white30),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(
                    Icons.g_mobiledata,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "Sign Up with Google",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _isLoading ? null : signInWithGoogle,
                ),
=======
                    : _actionButton(
                        "Sign Up",
                        signupUser,
                        Colors.amber.withOpacity(0.8),
                      ),
                const SizedBox(height: 15),
                _actionButton(
                  "Sign Up with Google",
                  signInWithGoogle,
                  Colors.white.withOpacity(0.2),
                ),
                const SizedBox(height: 20),
                _bottomLink(),
>>>>>>> Stashed changes
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassInputCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
<<<<<<< Updated upstream
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: child,
      ),
=======
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: child,
      ),
    );
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon, {
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white60),
      prefixIcon: Icon(icon, color: Colors.white70),
      suffixIcon: suffix,
      border: InputBorder.none,
    );
  }

  Widget _actionButton(String text, VoidCallback onTap, Color color) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _bottomLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          ),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
        ),
      ],
>>>>>>> Stashed changes
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
