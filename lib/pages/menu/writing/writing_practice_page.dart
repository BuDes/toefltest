// lib/pages/materials/writing/writing_practice_page.dart
import 'package:flutter/material.dart';
import 'package:toeflapp/models/section_model.dart';

const Color primaryBlue = Color(0xff6D94C5);
const Color cream1 = Color(0xffF5EFE6);

class WritingPracticePage extends StatefulWidget {
  final PracticeData practice;

  const WritingPracticePage({super.key, required this.practice});

  @override
  State<WritingPracticePage> createState() => _WritingPracticePageState();
}

class _WritingPracticePageState extends State<WritingPracticePage> {
  final TextEditingController _controller = TextEditingController();
  int _wordCount = 0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final text = _controller.text.trim();
      setState(() {
        _wordCount = text.isEmpty ? 0 : text.split(RegExp(r"\s+")).length;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.practice.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        iconTheme: const IconThemeData(color: primaryBlue),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg1.png"), // path asset kamu
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // instruction / reading passage
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Text(
                "📖 Reading passage:\n\n"
                "In many countries, people are debating whether online learning can fully "
                "replace traditional classrooms. Some argue that it provides flexibility "
                "and accessibility, while others worry about lack of personal interaction.\n\n"
                "You will now listen to a lecture that presents the opposite view.",
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
            const SizedBox(height: 16),

            // mock audio player
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() => _isPlaying = !_isPlaying);
                    },
                    icon: Icon(
                      _isPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: primaryBlue,
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text("🎧 Listening passage (mock audio)"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // writing area
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: _controller,
                minLines: 6, // tinggi awal (misalnya 6 baris)
                maxLines: null, // biar bisa bertambah sesuai teks
                decoration: const InputDecoration.collapsed(
                  hintText: "Tulis jawabanmu di sini...",
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Word count: $_wordCount",
              style: const TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Submit Essay"),
                    content: Text("Word count: $_wordCount"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                "Submit Answer",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
