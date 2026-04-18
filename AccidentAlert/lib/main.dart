import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/ambulance_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
// import 'screens/location_screen.dart';
// import 'navigation/main_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 2. Firebase initialize karna (Kyunki aapke paas google-services.json hai)
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  runApp(const MyApp());
}
// await Firebase.initializeApp();
// WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
// FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Accident Alert App',
      // home: const LocationScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        // '/': (context) => const OnBoardingScreen(),
        '/onboarding': (context) => const OnBoardingScreen(),
        '/ambulance': (context) => const AmbulanceScreen(),
        '/auth': (context) => const AuthScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
      },
    );
  }
}
