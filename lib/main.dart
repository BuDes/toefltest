import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/auth/login_page.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  // Aktifkan edge-to-edge mode biar nav bar gak hitam
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Styling status & nav bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent, // transparan beneran
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // kalau background terang
      systemNavigationBarIconBrightness: Brightness.dark,
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
