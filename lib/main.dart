import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart'; // ✅ Tambahkan ini
import 'package:provider/provider.dart';
import 'package:toeflapp/pages/auth/auth_check.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/auth_view_model.dart';
import 'package:toeflapp/view_models/materi_view_model.dart';
import 'package:toeflapp/view_models/riwayat_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Inisialisasi data lokal (contoh: Bahasa Indonesia)
  await initializeDateFormatting('id_ID', null);

  // Aktifkan edge-to-edge mode biar nav bar gak hitam
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Styling status & nav bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
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
        ChangeNotifierProvider(create: (context) => RiwayatViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Berlingvo',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Poppins",
          primaryColor: AppColors.primary,
        ),
        home: const AuthCheck(),
      ),
    );
  }
}
