import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Test Online",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Color.fromARGB(255, 254, 254, 255), Color.fromARGB(255, 230, 239, 255)],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 24),
          children: [
            Text(
              "📚 Daftar Test",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),

            _testTile(
              "TOEFL Practice Test 1",
              "Available Anytime",
              Colors.blue,
            ),
            _testTile(
              "TOEFL Practice Test 2",
              "Available Anytime",
              Colors.teal,
            ),
            _testTile(
              "Mock Test - September",
              "Available 25 Sep 2025",
              Colors.pinkAccent,
            ),

            const SizedBox(height: 32),
            Text(
              "🗓️ Jadwal Test",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),

            _scheduleTile("Mock Test October", "10 Oct 2025"),
            _scheduleTile("Mock Test November", "15 Nov 2025"),
          ],
        ),
      ),
    );
  }

  Widget _testTile(String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: Icon(Iconsax.document_text5, color: Colors.white, size: 30),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Iconsax.arrow_right_3, color: Colors.white),
        onTap: () {}, // TODO: navigate ke detail test
      ),
    );
  }

  Widget _scheduleTile(String title, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black26, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6FD8), Color(0xFF3813C2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Iconsax.calendar_25,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          const Icon(Iconsax.arrow_right_3, color: Colors.black54),
        ],
      ),
    );
  }
}
