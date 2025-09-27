import 'dart:math';
import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xff6D94C5);
const Color cream1 = Color(0xffF5EFE6);

class PracticeTestResultPage extends StatelessWidget {
  final dynamic practice; // expect fields: title, percentCorrect, isNew

  const PracticeTestResultPage({super.key, this.practice});

  @override
  Widget build(BuildContext context) {
    // 🔹 Dummy hasil soal
    final List<Map<String, dynamic>> results = [
      {
        "question": "What is the capital of France?",
        "options": ["Berlin", "Paris", "Madrid", "Rome"],
        "correctIndex": 1,
        "userIndex": 0,
      },
      {
        "question": "Which planet is known as the Red Planet?",
        "options": ["Earth", "Venus", "Mars", "Jupiter"],
        "correctIndex": 2,
        "userIndex": 2,
      },
      {
        "question": "TOEFL is mainly used for?",
        "options": [
          "Measuring English proficiency",
          "Learning programming",
          "Testing math skills",
          "Fitness training",
        ],
        "correctIndex": 0,
        "userIndex": 3,
      },
    ];

    // 🔹 Hitung skor
    final totalQuestions = results.length;
    final correctAnswers = results
        .where((q) => q["correctIndex"] == q["userIndex"])
        .length;

    final double percent = (correctAnswers / totalQuestions) * 100;

    return Scaffold(
      backgroundColor: cream1,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 2,
        title: const Text(
          "Hasil Practice Test",
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
                // 🔹 Header Skor
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xffE8DFCA),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Ringkasan Hasil",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: primaryBlue,
                        ),
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
                                valueColor: const AlwaysStoppedAnimation<Color>(
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
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _scoreItem("Benar", "$correctAnswers"),
                          _scoreItem(
                            "Salah",
                            "${totalQuestions - correctAnswers}",
                          ),
                          _scoreItem(
                            "Skor",
                            "${((correctAnswers / totalQuestions) * 100).toStringAsFixed(0)}%",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 List Soal
                const Text(
                  "Detail Jawaban",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 12),

                ...results.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  return _questionCard(
                    index: index,
                    question: data["question"],
                    options: List<String>.from(data["options"]),
                    correctIndex: data["correctIndex"],
                    userIndex: data["userIndex"],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _scoreItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _questionCard({
    required int index,
    required String question,
    required List<String> options,
    required int correctIndex,
    required int userIndex,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffE8DFCA), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Pertanyaan
          Text(
            "Q${index + 1}. $question",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // 🔹 Pilihan
          ...options.asMap().entries.map((entry) {
            final i = entry.key;
            final option = entry.value;
            final isCorrect = i == correctIndex;
            final isUserChoice = i == userIndex;

            Color bgColor = Colors.white;
            IconData? icon;

            if (isUserChoice && isCorrect) {
              bgColor = Colors.green.withOpacity(0.1);
              icon = Icons.check_circle;
            } else if (isUserChoice && !isCorrect) {
              bgColor = Colors.red.withOpacity(0.1);
              icon = Icons.cancel;
            } else if (isCorrect) {
              bgColor = Colors.green.withOpacity(0.05);
              icon = Icons.check;
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCorrect
                      ? Colors.green
                      : (isUserChoice ? Colors.red : Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(option, style: const TextStyle(fontSize: 14)),
                  ),
                  if (icon != null)
                    Icon(
                      icon,
                      size: 18,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
