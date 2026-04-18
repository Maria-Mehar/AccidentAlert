import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:accident_alert/screens/home_screen.dart';
import 'package:accident_alert/screens/location_screen.dart';
import 'package:accident_alert/screens/history_screen.dart';
import 'package:accident_alert/screens/notification_screen.dart';
import 'package:accident_alert/screens/setting_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _pageIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),

    const LocationScreen(),
    const HistoryScreen(),
    const NotificationScreen(),

    const SettingsPage(),
  ];

  final List<Widget> _navigationItems = const [
    Icon(Icons.home, color: Colors.white),

    Icon(Icons.location_on, color: Colors.white),
    Icon(Icons.access_time_outlined, color: Colors.white),
    Icon(Icons.notifications, color: Colors.white),
    Icon(Icons.settings, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_pageIndex],

      bottomNavigationBar: Container(
        color: const Color(0xFF1A1A1A),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: const Color(0xFF141414).withOpacity(0.95),
          buttonBackgroundColor: const Color(0xFFE53935),
          items: _navigationItems,
          index: _pageIndex,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            setState(() => _pageIndex = index);
          },
        ),
      ),
    );
  }
}
