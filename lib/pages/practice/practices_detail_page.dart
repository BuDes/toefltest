import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toeflapp/widgets/gradient_border.dart';

const Color primaryBlue = Color(0xff6D94C5);
const Color cream1 = Color(0xffF5EFE6);

class PracticeTestDetailPage extends StatefulWidget {
  final String testType;
  const PracticeTestDetailPage({super.key, required this.testType});

  @override
  State<PracticeTestDetailPage> createState() => _PracticeTestDetailPageState();
}

class _PracticeTestDetailPageState extends State<PracticeTestDetailPage> {
  bool _isStarted = false;
  int _currentSection = 0;
  int _currentQuestion = 0;
  bool _isPlayingAudio = false;

  // User answers disimpan di sini
  final Map<String, dynamic> _userAnswers = {};

  final List<Map<String, dynamic>> _sections = [
    {
      "title": "Listening",
      "questions": [
        {
          "question": "🎧 What is the main topic of the lecture?",
          "options": [
            "Climate Change",
            "Quantum Physics",
            "World War II",
            "Renaissance Art",
          ],
          "answer": 0,
        },
        {
          "question": "🎧 What does the speaker imply about global warming?",
          "options": [
            "It’s natural",
            "It’s caused by humans",
            "It’s a myth",
            "It’s slowing down",
          ],
          "answer": 1,
        },
      ],
    },
    {
      "title": "Reading",
      "passage":
          "Photosynthesis is a process used by plants to convert light energy into chemical energy. "
          "This process is essential for life on Earth because it produces oxygen and forms the base of the food chain.",
      "questions": [
        {
          "question":
              "📖 The passage suggests that photosynthesis is essential because…",
          "options": [
            "It produces oxygen",
            "It consumes oxygen",
            "It destroys CO2",
            "It creates fossils",
          ],
          "answer": 0,
        },
      ],
    },
    {
      "title": "Structure",
      "questions": [
        {
          "question": "📝 The committee has met and _______.",
          "options": [
            "they reached a decision",
            "it has reached a decision",
            "its decision was reached",
            "it reached a decision",
          ],
          "answer": 1,
        },
        {
          "question":
              "📝 Not until a student has mastered algebra _______ the principles of geometry.",
          "options": [
            "he can begin to understand",
            "can he begin to understand",
            "he begins to understand",
            "begins to understand",
          ],
          "answer": 1,
        },
      ],
    },
    {
      "title": "Writing",
      "questions": [
        {
          "question":
              "✍️ Some people think technology improves life, others say it worsens it. Discuss both views.",
          "options": [],
          "answer": null,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final section = _sections[_currentSection];
    return Scaffold(
      backgroundColor: cream1,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 2,
        title: Text(
          widget.testType,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: !_isStarted ? _buildIntro() : _buildTestUI(section),
    );
  }

  /// 🔹 Intro
  Widget _buildIntro() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        const Text(
          "📘 Petunjuk",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        const SizedBox(height: 12),
        GradientBorderContainer(
          child: const Text(
            "Latihan ini meniru ujian TOEFL yang sesungguhnya.\n\n"
            "Materi test tediri dari beberapa bagian: Listening, Reading, Writing, & Structure.\n"
            "Pastikan kamu berada di tempat yang tenang dan memiliki waktu yang cukup.",
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _infoCard(
                Iconsax.clock,
                "Perkiraan Waktu",
                widget.testType == "Full Test" ? "3 jam" : "1 jam",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _infoCard(Iconsax.document, "Jumlah Bagian", "4 bagian"),
            ),
          ],
        ),
        const SizedBox(height: 28),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () => setState(() => _isStarted = true),
          child: const Text(
            "Mulai Tes",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  /// 🔹 Test UI
  Widget _buildTestUI(Map<String, dynamic> section) {
    final questions = List<Map<String, dynamic>>.from(section["questions"]);
    final question = questions[_currentQuestion];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        LinearProgressIndicator(
          value: (_currentSection + 1) / _sections.length,
          color: primaryBlue,
          backgroundColor: Colors.grey.shade300,
          minHeight: 8,
          borderRadius: BorderRadius.circular(8),
        ),
        const SizedBox(height: 20),
        Text(
          "Section ${_currentSection + 1}: ${section["title"]}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        const SizedBox(height: 16),

        // 🔹 Content per Section
        if (section["title"] == "Listening") _buildListening(question),
        if (section["title"] == "Reading") _buildReading(section, question),
        if (section["title"] == "Structure") _buildStructure(question),
        if (section["title"] == "Writing") _buildWriting(question),

        const SizedBox(height: 28),
        _buildNavButtons(questions),
      ],
    );
  }

  /// 🔹 Listening Section
  Widget _buildListening(Map<String, dynamic> question) {
    return GradientBorderContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // audio player dummy
          Row(
            children: [
              IconButton(
                icon: Icon(
                  _isPlayingAudio ? Icons.pause_circle : Icons.play_circle,
                  size: 36,
                  color: primaryBlue,
                ),
                onPressed: () =>
                    setState(() => _isPlayingAudio = !_isPlayingAudio),
              ),
              Expanded(
                child: Slider(
                  value: _isPlayingAudio ? 0.5 : 0.0,
                  onChanged: (_) {},
                  activeColor: primaryBlue,
                  inactiveColor: Colors.grey.shade300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            question["question"],
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 12),
          ...List.generate(question["options"].length, (i) {
            return RadioListTile(
              value: i,
              groupValue: _userAnswers["Q$_currentSection-$_currentQuestion"],
              onChanged: (val) => setState(
                () => _userAnswers["Q$_currentSection-$_currentQuestion"] = val,
              ),
              title: Text(question["options"][i]),
              activeColor: primaryBlue,
            );
          }),
        ],
      ),
    );
  }

  /// 🔹 Reading Section
  Widget _buildReading(
    Map<String, dynamic> section,
    Map<String, dynamic> question,
  ) {
    return GradientBorderContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section["passage"],
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
          const Divider(height: 24, thickness: 1),
          Text(
            question["question"],
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          ...List.generate(question["options"].length, (i) {
            return RadioListTile(
              value: i,
              groupValue: _userAnswers["Q$_currentSection-$_currentQuestion"],
              onChanged: (val) => setState(
                () => _userAnswers["Q$_currentSection-$_currentQuestion"] = val,
              ),
              title: Text(question["options"][i]),
              activeColor: primaryBlue,
            );
          }),
        ],
      ),
    );
  }

  /// 🔹 structure Section
  Widget _buildStructure(Map<String, dynamic> question) {
    return GradientBorderContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question["question"],
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          ...List.generate(question["options"].length, (i) {
            return RadioListTile(
              value: i,
              groupValue: _userAnswers["Q$_currentSection-$_currentQuestion"],
              onChanged: (val) => setState(
                () => _userAnswers["Q$_currentSection-$_currentQuestion"] = val,
              ),
              title: Text(question["options"][i]),
              activeColor: primaryBlue,
            );
          }),
        ],
      ),
    );
  }

  /// 🔹 Writing Section
  Widget _buildWriting(Map<String, dynamic> question) {
    return GradientBorderContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question["question"],
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: 6,
            decoration: InputDecoration(
              hintText: "Write your essay here...",
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (val) =>
                _userAnswers["Q$_currentSection-$_currentQuestion"] = val,
          ),
        ],
      ),
    );
  }

  /// 🔹 Navigation Buttons
  Widget _buildNavButtons(List<Map<String, dynamic>> questions) {
    return Row(
      children: [
        if (_currentSection > 0 || _currentQuestion > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: _goBack,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text("Back", style: TextStyle(color: primaryBlue)),
            ),
          ),
        if (_currentSection > 0 || _currentQuestion > 0)
          const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _goNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              (_currentSection == _sections.length - 1 &&
                      _currentQuestion == questions.length - 1)
                  ? "Finish Test"
                  : "Next",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 Info Card
  Widget _infoCard(IconData icon, String title, String value) {
    return GradientBorderContainer(
      child: Column(
        children: [
          Icon(icon, color: primaryBlue, size: 28),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  /// 🔹 Navigation Logic
  void _goNext() {
    final questions = List<Map<String, dynamic>>.from(
      _sections[_currentSection]["questions"],
    );
    if (_currentQuestion < questions.length - 1) {
      setState(() => _currentQuestion++);
    } else if (_currentSection < _sections.length - 1) {
      setState(() {
        _currentSection++;
        _currentQuestion = 0;
      });
    } else {
      _showFinishDialog();
    }
  }

  void _goBack() {
    if (_currentQuestion > 0) {
      setState(() => _currentQuestion--);
    } else if (_currentSection > 0) {
      setState(() {
        _currentSection--;
        _currentQuestion =
            List<Map<String, dynamic>>.from(
              _sections[_currentSection]["questions"],
            ).length -
            1;
      });
    }
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Test Completed 🎉"),
        content: const Text(
          "You have finished the practice test.\n\nResults will appear in the next page.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: primaryBlue)),
          ),
        ],
      ),
    );
  }
}
