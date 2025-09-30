// lib/pages/menu/reading/reading_practice_page.dart
import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xff6D94C5);
const Color cream1 = Color(0xffF5EFE6);

class PracticeReadingPage extends StatefulWidget {
  final String practiceTitle;
  const PracticeReadingPage({super.key, required this.practiceTitle});

  @override
  State<PracticeReadingPage> createState() => _PracticeReadingPageState();
}

class _PracticeReadingPageState extends State<PracticeReadingPage> {
  final Map<int, int> _selected = {};

  final String passage = """
In the late nineteenth century, the rapid expansion of railroads in the United States 
had a significant impact on the economy and society. Railroads not only connected 
cities and towns but also opened vast new areas for settlement and commerce. 
Farmers could send their crops to distant markets, industries gained access to raw 
materials, and people experienced a level of mobility previously unimaginable.
""";

  final List<_Question> _questions = [
    _Question(
      id: 1,
      text: "What was one major effect of the expansion of railroads?",
      options: [
        "It limited settlement in rural areas.",
        "It restricted trade between cities.",
        "It connected regions and boosted commerce.",
        "It slowed industrial growth.",
      ],
    ),
    _Question(
      id: 2,
      text:
          "According to the passage, farmers benefited from railroads because:",
      options: [
        "They could sell crops in distant markets.",
        "They were given free land.",
        "They no longer needed raw materials.",
        "They had less mobility.",
      ],
    ),
  ];

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
            'Reading Comprehension',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Read the passage below and answer the questions that follow.",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 24),

          // Passage dalam kartu tersendiri
          Container(
            padding: const EdgeInsets.all(16),
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
            child: Text(
              passage,
              style: const TextStyle(fontSize: 14, height: 1.5),
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
                  title: const Text("Submit (UI-only)"),
                  content: Text("You selected ${_selected.length} answers."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
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
              "Submit answers",
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
            "Question ${question.id}",
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
