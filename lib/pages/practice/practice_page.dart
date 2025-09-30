import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toeflapp/pages/practice/practice_result_page.dart';
import 'practices_detail_page.dart'; // halaman simulasi test

class PracticeTestPage extends StatelessWidget {
  const PracticeTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6D94C5),
        elevation: 0,
        title: const Text(
          "Practice Test",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  "Simulasi TOEFL",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff6D94C5),
                  ),
                ),
                const SizedBox(height: 16),

                // 🔹 Mulai Simulasi Full Test
                _testCard(
                  context,
                  title: "Practice Test",
                  subtitle: "4 Bagian: Listening, Reading, Writing, & Structure",
                  icon: Icons.assignment,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PracticeTestDetailPage(
                          testType: "Full Practice Test",
                        ),
                      ),
                    );
                  },
                  buttonWidth: 90,
                ),

                // 🔹 Lihat Hasil Simulasi
                _testCard(
                  context,
                  title: "Hasil Practice Test",
                  subtitle: "Lihat skor & review percobaan sebelumnya",
                  icon: Icons.bar_chart,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PracticeTestResultPage(),
                      ),
                    );
                  },
                  buttonText: "Lihat",
                  buttonWidth: 90,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _testCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    String buttonText = "Mulai",
    double? buttonWidth, // 👈 opsional lebar tombol
    TextStyle? buttonTextStyle, // 👈 opsional style teks tombol
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffE8DFCA), width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xffE8DFCA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xff6D94C5)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            // 🔹 Tombol bisa diatur width & style
            Container(
              width: buttonWidth, // kalau null -> auto fit
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                gradient: const LinearGradient(
                  colors: [Color(0xff6D94C5), Color(0xff89CFF0)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      buttonText,
                      style:
                          buttonTextStyle ??
                          const TextStyle(
                            // default kalau ga dikasih
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
