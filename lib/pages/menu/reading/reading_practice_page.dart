// lib/pages/practice_reading_page.dart
import 'dart:math';
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
        "It slowed industrial growth."
      ],
    ),
    _Question(
      id: 2,
      text: "According to the passage, farmers benefited from railroads because:",
      options: [
        "They could sell crops in distant markets.",
        "They were given free land.",
        "They no longer needed raw materials.",
        "They had less mobility."
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream1,
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
                const Text(
                  "Reading Passage",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Text(
                    passage,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
                const SizedBox(height: 20),
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
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Submit (UI-only)"),
                        content: Text(
                          "You selected ${_selected.length} answers.",
                        ),
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
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Submit answers",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
            "Question ${question.id}",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.text,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(question.options.length, (i) {
            final option = question.options[i];
            final checked = selectedIndex == i;
            return InkWell(
              onTap: () => onSelect(i),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
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
                          ? const Icon(Icons.check,
                              size: 14, color: primaryBlue)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "( ${String.fromCharCode(65 + i)} )",
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:
                          Text(option, style: const TextStyle(fontSize: 14)),
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
