import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:toeflapp/pages/chat_page.dart';
// import 'package:toeflapp/pages/home_page.dart';
// import 'package:toeflapp/pages/profile_page.dart';
// import 'package:toeflapp/pages/test_page.dart';
import 'pages/auth/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Bikin status bar & nav bar transparan, edge-to-edge
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced:
          false, // 🔥 penting untuk hilangkan scrim hitam
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TOEFL App',
      theme: ThemeData(useMaterial3: true, fontFamily: "Poppins"),
      home: const LoginPage(),
    );
  }
}

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = const [
//     HomePage(),
//     TestPage(),
//     ChatPage(),
//     ProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(index: _currentIndex, children: _pages),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) => setState(() => _currentIndex = index),
//         selectedItemColor: Color(0xFF194DFF),
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Test"),
//           BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }
