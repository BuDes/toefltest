import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toeflapp/pages/online_test/test_flow_pages.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF6D94C5), Color(0xffffa97a)], // 🎨 sesuai palet
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "Test Online",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // warna dummy, ketimpa shader
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Section Daftar Test
            const SectionHeader(
              title: "Daftar Test",
              icon: Iconsax.document_text5,
            ),
            const SizedBox(height: 16),

            _testTile(context, "TOEFL Practice Test 1", "Available Anytime"),
            _testTile(context, "TOEFL Practice Test 2", "Available Anytime"),
            _testTile(context, "Mock Test - September", "Available 25 Sep 2025"),

            const SizedBox(height: 32),

            // 🔹 Section Jadwal Test
            const SectionHeader(
              title: "Jadwal Test",
              icon: Iconsax.calendar_25,
            ),
            const SizedBox(height: 16),

            _scheduleTile("Mock Test October", "10 Oct 2025", "10:00 AM"),
            _scheduleTile("Mock Test November", "15 Nov 2025", "02:00 PM"),
            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  Widget _testTile(BuildContext context, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xffF5EFE6), Color(0xffE8DFCA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color.fromARGB(255, 120, 158, 193),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: const AppIcon(
          icon: Iconsax.document_text5,
          iconColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 80, 113, 149),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xff6D94C5),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.black54, fontSize: 13),
        ),
        trailing: const Icon(
          Iconsax.arrow_right_3,
          color: Color.fromARGB(137, 65, 116, 158),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TestDetailPage(testTitle: title),
            ),
          );
        },
      ),
    );
  }

  Widget _scheduleTile(String title, String date, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF5EFE6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffCBDCEB), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const AppIcon(
            icon: Iconsax.calendar_25,
            backgroundColor: Color(0xff6D94C5),
            iconColor: Colors.white,
            isCircle: true,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff6D94C5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 41, 59, 81),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Iconsax.arrow_right_3, color: Colors.black54),
        ],
      ),
    );
  }
}

/// 🔹 Komponen Icon Reusable
class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final bool isCircle;

  const AppIcon({
    super.key,
    required this.icon,
    this.backgroundColor = const Color(0xffCBDCEB), // default sesuai palet
    this.iconColor = const Color(0xff6D94C5),
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: isCircle ? null : BorderRadius.circular(12),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Icon(icon, color: iconColor, size: 22),
    );
  }
}

/// 🔹 Komponen Header Section
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionHeader({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIcon(icon: icon),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color(0xff6D94C5),
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}