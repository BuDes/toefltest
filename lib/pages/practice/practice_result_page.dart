import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/models/hasil_jawaban.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/test_view_model.dart';

const Color primaryBlue = AppColors.primary;
const Color cream1 = Color(0xffF5EFE6);

class PracticeTestResultPage extends StatefulWidget {
  const PracticeTestResultPage({super.key});

  @override
  State<PracticeTestResultPage> createState() => _PracticeTestResultPageState();
}

class _PracticeTestResultPageState extends State<PracticeTestResultPage> {
  List<HasilJawaban> _results = [];

  void _loadResults() async {
    final testVM = context.read<TestViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final results = await testVM.hasilPracticeTest();
    if (results == null) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Terjadi kesalahan"),
          backgroundColor: Colors.grey,
        ),
      );
      navigator.pop();
      return;
    }
    setState(() => _results = results);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadResults();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 Hitung skor
    final totalQuestions = _results.length;
    final correctAnswers = _results.where((r) => r.isBenar).length;
    double percent = (correctAnswers / totalQuestions) * 100;
    if (totalQuestions == 0) percent = 0;

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
                            "${percent.toStringAsFixed(0)}%",
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

                ..._results.asMap().entries.map((entry) {
                  final data = entry.value;
                  return _questionCard(data);
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

  Widget _questionCard(HasilJawaban data) {
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
            data.pertanyaan,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          ...List.generate(data.opsi.length, (index) {
            final opsi = data.opsi[index];
            final isCorrect = opsi.id == data.idOpsiBenar;
            final isUserChoice = opsi.id == data.idOpsi;

            Color bgColor = Colors.white;
            IconData? icon;

            if (data.idOpsi == null && isCorrect) {
              bgColor = Colors.orange.withOpacity(0.05);
            } else if (isUserChoice && isCorrect) {
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
                      ? data.idOpsi != null
                            ? Colors.green
                            : Colors.orange
                      : (isUserChoice ? Colors.red : Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(opsi.isi, style: const TextStyle(fontSize: 14)),
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
