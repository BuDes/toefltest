import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/pages/auth/auth_button.dart';
import 'package:toeflapp/pages/auth/auth_text_field.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/auth_view_model.dart';
import 'package:toeflapp/widgets/botom_nav.dart';
import 'package:toeflapp/pages/auth/register_page.dart';
import 'package:toeflapp/widgets/error_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  String? _error;

  void _submitLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final navigator = Navigator.of(context);
    setState(() {
      _loading = true;
      _error = null;
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final error = await context.read<AuthViewModel>().login(email, password);
    if (error == null) {
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const BottomNav(),
        ),
        (route) => false,
      );
      return;
    }

    setState(() {
      _loading = false;
      _error = error;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      // resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          // systemNavigationBarColor: Colors.,
          // systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    width: size.width * 0.9,
                    padding: const EdgeInsets.all(28.0),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white24, width: 1.2),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: size.width * 0.2,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Welcome Back ✨",
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,

                                  color: AppColors.primary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          ErrorView(error: _error),
                          AuthTextField(
                            controller: _emailController,
                            hint: "Email",
                            icon: Icons.mail_rounded,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          AuthTextField(
                            controller: _passwordController,
                            hint: "Password",
                            icon: Icons.lock_rounded,
                            isPassword: true,
                          ),
                          const SizedBox(height: 30),
                          AuthButton(
                            onPressed: _submitLogin,
                            text: "Login",
                            loading: _loading,
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterPage(),
                                ),
                              );
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: "Belum punya akun? ",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Register",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
