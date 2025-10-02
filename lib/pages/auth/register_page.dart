import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/pages/auth/auth_button.dart';
import 'package:toeflapp/pages/auth/auth_text_field.dart';
import 'package:toeflapp/pages/auth/models/new_user.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/auth_view_model.dart';
import 'package:toeflapp/widgets/botom_nav.dart';
import 'package:toeflapp/widgets/error_view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _kPasswordController = TextEditingController();

  bool _loading = false;
  String? _error;

  void _submitRegister() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    final navigator = Navigator.of(context);
    final nama = _namaController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final user = NewUser(
      nama: nama,
      email: email,
      password: password,
    );

    final error = await context.read<AuthViewModel>().register(user);
    if (error == null) {
      if (error == null) {
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BottomNav(),
          ),
          (route) => false,
        );
        return;
      }
    }

    setState(() {
      _loading = false;
      _error = error;
    });
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password tidak boleh kosong";
    }
    if (_passwordController.text != _kPasswordController.text) {
      return "Kedua password tidak sama";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
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
                    border: Border.all(
                      color: Colors.white24,
                      width: 1.2,
                    ),
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
                          "Create Account ✨",
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
                          controller: _namaController,
                          hint: "Full Name",
                          icon: Icons.person_rounded,
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 20),
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
                          validator: _passwordValidator,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          controller: _kPasswordController,
                          hint: "Confirm Password",
                          icon: Icons.lock_rounded,
                          isPassword: true,
                          validator: _passwordValidator,
                        ),
                        const SizedBox(height: 30),
                        AuthButton(
                          onPressed: _submitRegister,
                          text: "Register",
                          loading: _loading,
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: RichText(
                            text: const TextSpan(
                              text: "Sudah punya akun? ",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: "Login",
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
    );
  }
}
