import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toeflapp/pages/materials/listening/listening_page.dart';
import 'package:toeflapp/pages/materials/full_practice_page.dart';
import 'package:toeflapp/pages/materials/reading/reading_page.dart';
import 'package:toeflapp/pages/materials/speaking/speaking_page.dart';
import 'package:toeflapp/pages/materials/writing/writing_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Selamat Datang.. 👋",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff6D94C5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Jenis Materi',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff6D94C5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _menuCard(
                        context,
                        SvgPicture.asset(
                          'assets/images/icon_headphones.svg',
                          width: 35,
                          height: 35,
                          color: const Color(0xffffa97a),
                        ),
                        "Listening",
                        "200+ Audio",
                        onTap: () => _goTo(context, const ListeningPage()),
                      ),
                      _menuCard(
                        context,
                        SvgPicture.asset(
                          'assets/images/icon_reading.svg',
                          width: 35,
                          height: 35,
                          color: const Color(0xffffa97a),
                        ),
                        "Reading",
                        "400+ Pertanyaan",
                        onTap: () => _goTo(context, const ReadingPage()),
                      ),
                      _menuCard(
                        context,
                        SvgPicture.asset(
                          'assets/images/icon_person.svg',
                          width: 35,
                          height: 35,
                          color: const Color(0xffffa97a),
                        ),
                        "Speaking",
                        "50+ Topik",
                        onTap: () => _goTo(context, const SpeakingPage()),
                      ),
                      _menuCard(
                        context,
                        SvgPicture.asset(
                          'assets/images/icon_pen.svg',
                          width: 35,
                          height: 35,
                          color: const Color(0xffffa97a),
                        ),
                        "Writing",
                        "100+ Sampel",
                        onTap: () => _goTo(context, const WritingPage()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Practice Test",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff6D94C5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => _goTo(context, const FullPracticeTestPage()),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xffF5EFE6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 154, 186, 212),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xffE8DFCA),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.app_registration_rounded,
                              color: Color(0xff6D94C5),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Full Practice Test",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xff6D94C5),
                                  ),
                                ),
                                Text(
                                  "Simulasi lengkap ujian TOEFL",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Progress Belajar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 20),
                      children: [
                        const SizedBox(height: 8),
                        _progressTile("Speaking", 0.6, [
                          Color(0xffffa97a),
                          Color(0xffF5EFE6),
                        ]),
                        _progressTile("Reading", 0.3, [
                          Color(0xffffa97a),
                          Color(0xffF5EFE6),
                        ]),
                        _progressTile("Listening", 0.8, [
                          Color(0xffffa97a),
                          Color(0xffF5EFE6),
                        ]),
                        _progressTile("Writing", 0.4, [
                          Color(0xffffa97a),
                          Color(0xffF5EFE6),
                        ]),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Card Menu
  Widget _menuCard(
    BuildContext context,
    Widget icon,
    String title,
    String subtitle, {
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 56) / 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xffF5EFE6), Color.fromARGB(255, 255, 255, 255)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(padding: const EdgeInsets.all(12), child: icon),
                const SizedBox(height: 12),
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
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Progress Tile
  Widget _progressTile(String title, double value, List<Color> gradient) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              Text(
                '${(value * 100).toInt()}%',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    width: constraints.maxWidth * value,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradient,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
