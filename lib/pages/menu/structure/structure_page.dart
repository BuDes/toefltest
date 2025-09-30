import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toeflapp/models/section_model.dart';
import 'package:toeflapp/pages/menu/practice_detail_page.dart';
import 'package:toeflapp/widgets/section_card.dart';

const Color primaryBlue = Color(0xff6D94C5);
const Color cream1 = Color(0xffF5EFE6);

class StructurePage extends StatelessWidget {
  const StructurePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy yang relevan untuk section Structure
    final List<SectionData> sections = [
      SectionData(
        title: 'Sentence Completion',
        icon: Icons.edit_note,
        totalTests: 25,
        percentCorrect: 0.75, // contoh progress
        practices: List.generate(
          5,
          (i) => PracticeData(
            id: i + 201,
            title: 'Practice ${i + 1}',
            percentCorrect: 0,
            isNew: i < 2,
          ),
        ),
      ),
      SectionData(
        title: 'Error Identification',
        icon: Icons.error_outline,
        totalTests: 25,
        percentCorrect: 0.40, // contoh progress
        practices: List.generate(
          4,
          (i) => PracticeData(
            id: i + 251,
            title: 'Practice ${i + 1}',
            percentCorrect: 0,
            isNew: i < 1,
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
          "Structure",
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
                    'Choose a section to start',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Render sections
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
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}