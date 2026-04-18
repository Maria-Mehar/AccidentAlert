// import 'package:accident_alert/screens/monitor_screen.dart';
// import 'package:accident_alert/screens/home_screen.dart';
// import 'package:accident_alert/screens/home_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/ambulance_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/vehicle_selection.dart';
// import 'screens/monitor_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';

//import 'screens/home.dart';
import 'navigation/main_layout.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Accident Alert App',
      // home: const/ LoginScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        // '/': (context) => const OnBoardingScreen(),
        '/onboarding': (context) => const OnBoardingScreen(),
        '/ambulance': (context) => const AmbulanceScreen(),
        '/auth': (context) => const AuthScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),

        '/vehicle': (context) => const VehicleSelectionScreen(),
        '/home': (context) => const HomeScreen(),
        '/main': (context) => const MainLayout(),
      },
    );
  }
}
