import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "Tanya Pakar 💬",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // warna dummy, ketimpa shader
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ilustrasi/emoji besar untuk empty state
            const Text("📩", style: TextStyle(fontSize: 72)),
            const SizedBox(height: 20),
            const Text(
              "Belum ada chat",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Tanyakan apapun seputar TOEFL\ndan pakar akan menjawab ✨",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black45, fontSize: 14),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 72,
        ), // naikin FAB 72px dari bawah
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {},
            child: const Icon(
              Iconsax.message_add,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
