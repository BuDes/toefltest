import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toeflapp/pages/chat_page.dart';
import 'package:toeflapp/pages/home_page.dart';
import 'package:toeflapp/pages/profile_page.dart';
import 'package:toeflapp/pages/test_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    TestPage(),
    ChatPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // biar nav bar bisa floating di atas background
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white.withOpacity(0.15),
              selectedItemColor: const Color(0xFF013BFF),
              unselectedItemColor: Color(0xFF013BFF),
              showUnselectedLabels: false,
              selectedFontSize: 14,
              unselectedFontSize: 12,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.home),
                  activeIcon: Icon(Iconsax.home5, size: 28),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.task_square),
                  activeIcon: Icon(Iconsax.task_square5, size: 28),
                  label: "Test",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.message),
                  activeIcon: Icon(Iconsax.message5, size: 28),
                  label: "Chat",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.profile_tick),
                  activeIcon: Icon(Iconsax.profile_tick5, size: 28),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
