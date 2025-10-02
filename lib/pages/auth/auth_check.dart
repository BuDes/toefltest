import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/pages/auth/login_page.dart';
import 'package:toeflapp/view_models/auth_view_model.dart';
import 'package:toeflapp/widgets/botom_nav.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  void _checkToken() async {
    final authVM = context.read<AuthViewModel>();
    final navigator = Navigator.of(context);
    Widget page = const LoginPage();

    final loggedIn = await authVM.loadProfile();
    if (loggedIn) {
      page = const BottomNav();
    }

    navigator.pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
