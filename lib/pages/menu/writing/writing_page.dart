// lib/pages/writing_page.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toeflapp/models/section_model.dart';
import 'package:toeflapp/pages/menu/practice_detail_page.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/widgets/section_card.dart';

const Color primaryBlue = AppColors.primary;
const Color cream1 = Color(0xffF5EFE6);

class WritingPage extends StatelessWidget {
  const WritingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SectionData> sections = [
      SectionData(
        title: "Integrated Writing",
        icon: Icons.library_books,
        totalTests: 3,
        percentCorrect: 0,
        practices: List.generate(
          3,
          (i) => PracticeData(
            id: i + 300,
            title: "Task ${i + 1}",
            percentCorrect: 0,
            isNew: true,
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
          "Writing",
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
                    "Choose a task to start",
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
