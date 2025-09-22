import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "TOEFL Skills",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👋 Welcome
            const Text(
              "Welcome to TOEFL App 👋",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Menu pakai Wrap (jarak lebih rapat, fleksibel)
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _menuCard(
                  context,
                  SvgPicture.asset('assets/images/icon_headphones.svg',
                      width: 44, height: 44),
                  "Listening",
                  "200+ Audio",
                ),
                _menuCard(
                  context,
                  SvgPicture.asset('assets/images/icon_reading.svg',
                      width: 44, height: 44),
                  "Reading",
                  "400+ Questions",
                ),
                _menuCard(
                  context,
                  SvgPicture.asset('assets/images/icon_person.svg',
                      width: 44, height: 44),
                  "Speaking",
                  "50+ Topics",
                ),
                _menuCard(
                  context,
                  SvgPicture.asset('assets/images/icon_pen.svg',
                      width: 44, height: 44),
                  "Writing",
                  "100+ Samples",
                ),
              ],
            ),

            const SizedBox(height: 20), // lebih rapat dari sebelumnya

            // 🔹 Progress Section
            const Text(
              "Progress Belajar",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            _progressTile("Speaking", 0.6, [Colors.purple, Colors.blue]),
            _progressTile("Reading", 0.3, [Colors.red, Colors.orange]),
            _progressTile("Listening", 0.8, [Colors.green, Colors.teal]),
            _progressTile("Writing", 0.4, [Colors.pink, Colors.deepPurple]),
          ],
        ),
      ),
    );
  }

  // 🔹 Card Menu (Putih modern) — ukurannya fixed biar rapih
  Widget _menuCard(
    BuildContext context,
    Widget icon,
    String title,
    String subtitle,
  ) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 56) / 2, // 20+20 padding + 16 spacing
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // TODO: Navigate ke materi
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: icon,
                ),
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

  // 🔹 Progress Tile (gradient bar)
  Widget _progressTile(String title, double value, List<Color> gradient) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
