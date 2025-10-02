import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/pages/auth/auth_check.dart';
import 'package:toeflapp/view_models/auth_view_model.dart';
import 'package:toeflapp/view_models/materi_view_model.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => MateriViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TOEFL App',
        theme: ThemeData(useMaterial3: true, fontFamily: "Poppins"),
        home: const AuthCheck(),
      ),
    );
  }
}
