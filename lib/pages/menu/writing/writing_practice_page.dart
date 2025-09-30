// lib/pages/menu/writing/writing_practice_page.dart
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
      backgroundColor: cream1, // [DIUBAH] Background utama
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          widget.practice.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        iconTheme: const IconThemeData(color: primaryBlue),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Integrated Writing Task',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Read the passage, listen to the lecture, and then write your response.",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 24),

          // Reading passage dalam kartu
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Text(
              "📖 Reading passage:\n\n"
              "In many countries, people are debating whether online learning can fully "
              "replace traditional classrooms. Some argue that it provides flexibility "
              "and accessibility, while others worry about lack of personal interaction.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ),

          // Mock audio player dalam kartu
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
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

          // Writing area dalam kartu
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TextField(
              controller: _controller,
              minLines: 8,
              maxLines: null,
              decoration: const InputDecoration.collapsed(
                hintText: "Start writing your response here...",
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              "Word count: $_wordCount",
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.black54),
            ),
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
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
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
