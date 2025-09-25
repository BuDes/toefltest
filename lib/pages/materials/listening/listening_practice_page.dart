// lib/pages/practice_test_page.dart
import 'dart:math';
import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xff6D94C5);
const Color cream1 = Color(0xffF5EFE6);
const Color cream2 = Color(0xffE8DFCA);

class PracticeListeningPage extends StatefulWidget {
  final String practiceTitle;
  const PracticeListeningPage({super.key, required this.practiceTitle});

  @override
  State<PracticeListeningPage> createState() => _PracticeListeningPageState();
}

class _PracticeListeningPageState extends State<PracticeListeningPage> {
  // simple mock for audio time
  double _audioProgress = 0.2;
  bool _playing = false;

  // mock questions
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

  // selected answers (UI-only)
  final Map<int, int> _selected = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.practiceTitle,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                Row(
                  children: [
                    const Text(
                      'Question 1-5',
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: 0.12,
                          alignment: Alignment.centerLeft,
                          child: Container(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.grid_view_rounded, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // audio player mock
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
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
                            onPressed: () =>
                                setState(() => _playing = !_playing),
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
                              onChanged: (v) => setState(
                                () => _audioProgress = v.clamp(0.0, 1.0),
                              ),
                            ),
                          ),
                          Text(
                            '4:36',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // questions
                ..._questions.map(
                  (q) => _QuestionCard(
                    question: q,
                    selectedIndex: _selected[q.id],
                    onSelect: (index) =>
                        setState(() => _selected[q.id] = index),
                  ),
                ),

                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // UI-only: show simple result
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
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Submit answers',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xffffa97a),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8),
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
          const SizedBox(height: 12),
          ...List.generate(question.options.length, (i) {
            final option = question.options[i];
            final checked = selectedIndex == i;
            return InkWell(
              onTap: () => onSelect(i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: checked ? primaryBlue : Colors.grey.shade300,
                          width: 2,
                        ),
                        color: checked
                            ? primaryBlue.withOpacity(0.12)
                            : Colors.transparent,
                      ),
                      child: checked
                          ? const Icon(
                              Icons.check,
                              size: 14,
                              color: primaryBlue,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '( ${String.fromCharCode(65 + i)} )',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(option, style: const TextStyle(fontSize: 14)),
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
