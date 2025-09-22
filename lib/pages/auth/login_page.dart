import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toeflapp/main_page.dart';
import 'package:toeflapp/pages/auth/resgister_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 162, 206, 233), // vibrant purple
              Color(0xff013BFF), // vibrant blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.2,
                    ),
                  ),
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
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      _buildTextField(hint: "Email", icon: Icons.mail_rounded),
                      const SizedBox(height: 20),
                      _buildTextField(
                        hint: "Password",
                        icon: Icons.lock_rounded,
                        obscure: true,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 6,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MainPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Row(
                      //   children: [
                      //     Expanded(child: Divider(color: Colors.white54)),
                      //     const Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 12),
                      //       child: Text("or continue with",
                      //           style: TextStyle(color: Colors.white70)),
                      //     ),
                      //     Expanded(child: Divider(color: Colors.white54)),
                      //   ],
                      // ),
                      // const SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     _socialButton("assets/icons/google.png"),
                      //     const SizedBox(width: 16),
                      //     _socialButton("assets/icons/apple.png"),
                      //   ],
                      // ),
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
                            text: "Don’t have an account? ",
                            style: TextStyle(color: Colors.white70),
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
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
