import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toeflapp/models/section_model.dart';
import 'package:toeflapp/theme/app_colors.dart';

const Color primaryBlue = AppColors.primary;
const Color cream1 = Color(0xffF5EFE6);

// Enum untuk membedakan tipe soal
enum QuestionType { completion, errorIdentification }

// Model untuk soal structure
class _StructureQuestion {
  final int id;
  final QuestionType type;
  final String text; // Untuk completion
  final List<TextSpan> richText; // Untuk error identification
  final List<String> options;
  final int correctAnswerIndex;

  _StructureQuestion({
    required this.id,
    required this.type,
    this.text = '',
    this.richText = const [],
    required this.options,
    required this.correctAnswerIndex,
  });
}

class StructurePracticePage extends StatefulWidget {
  final PracticeData practice;
  final String sectionTitle;

  const StructurePracticePage({
    super.key,
    required this.practice,
    required this.sectionTitle,
  });

  @override
  State<StructurePracticePage> createState() => _StructurePracticePageState();
}

class _StructurePracticePageState extends State<StructurePracticePage> {
  late List<_StructureQuestion> _questions;
  final Map<int, int> _selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    // Generate soal dummy berdasarkan section title
    _questions = _generateDummyQuestions(widget.sectionTitle);
  }

  List<_StructureQuestion> _generateDummyQuestions(String sectionTitle) {
    if (sectionTitle.contains("Completion")) {
      return [
        _StructureQuestion(
          id: 1,
          type: QuestionType.completion,
          text: "The committee has met and _______.",
          options: [
            "they reached a decision",
            "it has reached a decision",
            "its decision was reached",
            "it reached a decision",
          ],
          correctAnswerIndex: 1,
        ),
        _StructureQuestion(
          id: 2,
          type: QuestionType.completion,
          text:
              "The manager was angry because his secreatary _______ to type the letter.",
          options: ["has forgot", "was forgetting", "had forgotten", "forgets"],
          correctAnswerIndex: 2,
        ),
      ];
    } else {
      // Error Identification
      return [
        _StructureQuestion(
          id: 3,
          type: QuestionType.errorIdentification,
          richText: [
            const TextSpan(
              text:
                  "Some of the plants in this store requires very little care, but this one needs much more sunlight than the ",
            ),
            _underlined("others ones", 'A'),
            const TextSpan(text: ". This is a "),
            _underlined("challenging", 'B'),
            const TextSpan(text: " plant for a "),
            _underlined("beginner", 'C'),
            const TextSpan(text: " to "),
            _underlined("grow", 'D'),
            const TextSpan(text: "."),
          ],
          options: ["others ones", "challenging", "beginner", "grow"],
          correctAnswerIndex: 0,
        ),
        _StructureQuestion(
          id: 4,
          type: QuestionType.errorIdentification,
          richText: [
            const TextSpan(text: "After the student "),
            _underlined("explained", 'A'),
            const TextSpan(text: " his problem to the "),
            _underlined("counselor", 'B'),
            const TextSpan(text: ", "),
            _underlined("them", 'C'),
            const TextSpan(text: " advised him to take a "),
            _underlined("leave of absence", 'D'),
            const TextSpan(text: "."),
          ],
          options: ["explained", "counselor", "them", "leave of absence"],
          correctAnswerIndex: 2,
        ),
      ];
    }
  }

  // Helper untuk membuat TextSpan dengan garis bawah
  TextSpan _underlined(String text, String label) {
    return TextSpan(
      children: [
        TextSpan(
          text: text,
          style: const TextStyle(
            decoration: TextDecoration.underline,
            decorationColor: Colors.black87,
          ),
        ),
        TextSpan(
          text: ' ($label)',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // bisa tambahkan interaksi jika diperlukan
            },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream1,
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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            widget.sectionTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.sectionTitle.contains("Completion")
                ? "Choose the one word or phrase that best completes the sentence."
                : "Identify the one underlined word or phrase that must be changed for the sentence to be correct.",
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 24),
          ..._questions.map((q) => _buildQuestionCard(q)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Submit Answers'),
                  content: Text(
                    'You have answered ${_selectedAnswers.length} out of ${_questions.length} questions. Are you sure you want to submit?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Logika submit nanti di sini
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Answers submitted (UI only)!"),
                          ),
                        );
                      },
                      child: const Text('Submit'),
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
              'Submit',
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

  Widget _buildQuestionCard(_StructureQuestion question) {
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
          // Question text
          if (question.type == QuestionType.completion)
            Text(
              question.text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            )
          else
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
                children: question.richText,
              ),
            ),
          const SizedBox(height: 16),
          // Options
          ...List.generate(question.options.length, (i) {
            final isSelected = _selectedAnswers[question.id] == i;
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedAnswers[question.id] = i;
                });
              },
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
                        question.options[i],
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
