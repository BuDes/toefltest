// lib/pages/practice_detail_page.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toeflapp/pages/materials/listening/listening_practice_page.dart';
import 'package:toeflapp/pages/materials/reading/reading_practice_page.dart';
import 'package:toeflapp/pages/materials/speaking/speaking_practice_page.dart';
import 'package:toeflapp/pages/materials/writing/writing_practice_page.dart';

const Color primaryBlue = Color(0xff6D94C5);
const Color cream1 = Color(0xffF5EFE6);
const Color cream2 = Color(0xffE8DFCA);

class PracticeDetailPage extends StatelessWidget {
  final dynamic practice; // expect fields: title, percentCorrect, isNew
  final String sectionTitle;

  const PracticeDetailPage({
    super.key,
    required this.practice,
    required this.sectionTitle,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = (practice?.percentCorrect ?? 0.0) * 100;
    // sample stats (UI only)
    final int correct = ((practice?.percentCorrect ?? 0.0) * 10).toInt();
    final int incorrect = 4;
    final int newItems = practice?.isNew == true ? 1 : 0;
    final int marked = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          practice?.title ?? 'Practice',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundColor: cream2,
              child: Icon(Icons.emoji_events, color: primaryBlue),
            ),
          ),
        ],
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
                // Card with big circular progress + button
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Hasil latihan terbaru ',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 140,
                        width: 140,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 140,
                              width: 140,
                              child: CircularProgressIndicator(
                                value: (percent / 100).clamp(0.0, 1.0),
                                strokeWidth: 12,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  primaryBlue,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${percent.toInt()}%',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: primaryBlue,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Benar',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (sectionTitle == "Academic Passages") {
                            // Reading
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PracticeReadingPage(
                                  practiceTitle: practice?.title ?? "Practice",
                                ),
                              ),
                            );
                          } else if (sectionTitle == "Integrated Writing") {
                            // Writing
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    WritingPracticePage(practice: practice),
                              ),
                            );
                          } else if (sectionTitle.contains("Topics")) {
                            // Speaking
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    SpeakingPracticePage(practice: practice),
                              ),
                            );
                          } else {
                            // Listening
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PracticeListeningPage(
                                  practiceTitle: practice?.title ?? "Practice",
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 24,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                        ),
                        child: const Center(
                          child: Text(
                            'Latihan Soal',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF5EFE6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                // Stats rows (Correct / Incorrect / New / Marked)
                _StatRow(
                  label: 'Benar',
                  value: correct.toString(),
                  suffix: 'Kosong',
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                const SizedBox(height: 12),
                _StatRow(
                  label: 'Salah',
                  value: incorrect.toString(),
                  suffix: 'Practice',
                  icon: Icons.close,
                  color: Colors.red,
                ),
                const SizedBox(height: 12),
                _StatRow(
                  label: 'Baru',
                  value: newItems.toString(),
                  suffix: 'Practice',
                  icon: Icons.new_releases,
                  color: Colors.orange,
                ),
                const SizedBox(height: 12),
                _StatRow(
                  label: 'Di tandai',
                  value: marked.toString(),
                  suffix: 'Empty',
                  icon: Icons.bookmark,
                  color: Colors.purple,
                ),
                const SizedBox(height: 24),
                // quick description / tips
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Text(
                    'Tips: Selama sesi latihan berlangsung, fokus pada detail dan catatlah catatan singkat.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final String suffix;
  final IconData icon;
  final Color color;

  const _StatRow({
    required this.label,
    required this.value,
    required this.suffix,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          Row(
            // Use a new Row to contain the value and suffix
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                // Give the suffix a fixed width to ensure alignment
                width: 70, // Adjust this value as needed
                child: Text(
                  suffix,
                  style: const TextStyle(color: Colors.black38),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
