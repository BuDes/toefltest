import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/pages/chat/chat_page.dart';
import 'package:toeflapp/pages/home_page.dart';
import 'package:toeflapp/pages/profile/profile_page.dart';
import 'package:toeflapp/pages/online_test/test_page.dart';
import 'package:toeflapp/services/socket_service.dart';
import 'package:toeflapp/view_models/auth_view_model.dart';
import 'package:toeflapp/view_models/message_view_model.dart';
import 'package:toeflapp/view_models/riwayat_view_model.dart';
import 'package:toeflapp/view_models/test_view_model.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  final _socketService = SocketService();

  final List<Widget> _pages = const [
    HomePage(),
    TestPage(),
    ChatPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    final id = context.read<AuthViewModel>().currentUser!.id;
    _socketService.connect(id);
    context.read<MessageViewModel>().socketService = _socketService;
    context.read<RiwayatViewModel>().getRiwayat();
    context.read<TestViewModel>().getMyJadwal();
  }

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
              backgroundColor: Colors.white12,
              selectedItemColor: const Color.fromARGB(255, 58, 80, 107),
              unselectedItemColor: const Color.fromARGB(255, 44, 69, 100),
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
