// lib/pages/reading_page.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toeflapp/models/section_model.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/widgets/section_card.dart';
import '../practice_detail_page.dart';

const Color primaryBlue = AppColors.primary;
const Color cream1 = Color(0xffF5EFE6);
const Color cream2 = Color(0xffE8DFCA);

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SectionData> sections = [
      SectionData(
        title: "Academic Passages",
        icon: Icons.menu_book,
        totalTests: 40,
        percentCorrect: 0,
        practices: List.generate(
          3,
          (i) => PracticeData(
            id: i + 200,
            title: "Passage ${i + 1}",
            percentCorrect: 0,
            isNew: i < 2,
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: cream1,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 2,
        title: const Text(
          "Reading",
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: ListView(
                children: [
                  const Text(
                    "Choose a passage to start",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...sections.map(
                    (s) => SectionCard(
                      data: s,
                      onOpenPractice: (practice) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PracticeDetailPage(
                              practice: practice,
                              sectionTitle: s.title,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
