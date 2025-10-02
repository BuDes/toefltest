// lib/pages/menu/listening/listening_practice_page.dart
import 'package:flutter/material.dart';
import 'package:toeflapp/theme/app_colors.dart';

const Color primaryBlue = AppColors.primary;
const Color cream1 = Color(0xffF5EFE6);

class PracticeListeningPage extends StatefulWidget {
  final String practiceTitle;
  const PracticeListeningPage({super.key, required this.practiceTitle});

  @override
  State<PracticeListeningPage> createState() => _PracticeListeningPageState();
}

class _PracticeListeningPageState extends State<PracticeListeningPage> {
  double _audioProgress = 0.2;
  bool _playing = false;

  final List<_Question> _questions = [
    _Question(
      id: 1,
      text: 'Where does this conversation probably take place?',
      options: [
        'In a laboratory',
        'In a dormitory',
        'In a van',
        'In the countryside',
      ],
    ),
    _Question(
      id: 2,
      text: 'What were they doing yesterday?',
      options: ['Classifying', 'Camping', 'Collecting', 'Counting'],
    ),
  ];

  final Map<int, int> _selected = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream1, // [DIUBAH] Background utama
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          widget.practiceTitle,
          style: const TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: primaryBlue),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Listening Comprehension',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Listen to the audio carefully and answer the questions that follow.",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 24),

          // Audio player dalam kartu tersendiri
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Audio Recording',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() => _playing = !_playing),
                      icon: Icon(
                        _playing
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        size: 36,
                        color: primaryBlue,
                      ),
                    ),
                    Text(
                      _formatTime(_audioProgress * 4.36),
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Slider(
                        value: _audioProgress,
                        onChanged: (v) =>
                            setState(() => _audioProgress = v.clamp(0.0, 1.0)),
                      ),
                    ),
                    const Text('4:36', style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),

          // Soal-soal
          ..._questions.map(
            (q) => _QuestionCard(
              question: q,
              selectedIndex: _selected[q.id],
              onSelect: (index) => setState(() => _selected[q.id] = index),
            ),
          ),

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Submit (UI-only)'),
                  content: Text(
                    'You selected ${_selected.length} answers. This is UI only; backend integration later.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Submit answers',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  String _formatTime(double minutes) {
    final int mins = minutes.truncate();
    final int secs = ((minutes - mins) * 60).truncate();
    return '${mins.toString()}:${secs.toString().padLeft(2, '0')}';
  }
}

class _Question {
  final int id;
  final String text;
  final List<String> options;
  _Question({required this.id, required this.text, required this.options});
}

class _QuestionCard extends StatelessWidget {
  final _Question question;
  final int? selectedIndex;
  final void Function(int) onSelect;

  const _QuestionCard({
    required this.question,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${question.id}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.text,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ...List.generate(question.options.length, (i) {
            final option = question.options[i];
            final isSelected = selectedIndex == i;
            return InkWell(
              onTap: () => onSelect(i),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? primaryBlue.withOpacity(0.1)
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? primaryBlue : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      '${String.fromCharCode(65 + i)}.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? primaryBlue : Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option,
                        style: TextStyle(
                          color: isSelected ? primaryBlue : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
