// lib/pages/speaking_page.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toeflapp/models/section_model.dart';
import 'package:toeflapp/pages/materials/practice_detail_page.dart';
import 'package:toeflapp/widgets/section_card.dart';

const Color primaryBlue = Color(0xff6D94C5);
const Color cream1 = Color(0xffF5EFE6);

class SpeakingPage extends StatelessWidget {
  const SpeakingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SectionData> sections = [
      SectionData(
        title: "Personal Topics",
        icon: Icons.person,
        totalTests: 3,
        percentCorrect: 0,
        practices: List.generate(
          3,
          (i) => PracticeData(
            id: i + 400,
            title: "Task ${i + 1}",
            percentCorrect: 0,
            isNew: i < 2,
          ),
        ),
      ),
      SectionData(
        title: "Opinion Topics",
        icon: Icons.chat_bubble,
        totalTests: 3,
        percentCorrect: 0,
        practices: List.generate(
          3,
          (i) => PracticeData(
            id: i + 500,
            title: "Task ${i + 1}",
            percentCorrect: 0,
            isNew: i == 0,
          ),
        ),
      ),
      SectionData(
        title: "Academic Topics",
        icon: Icons.school,
        totalTests: 3,
        percentCorrect: 0,
        practices: List.generate(
          3,
          (i) => PracticeData(
            id: i + 600,
            title: "Task ${i + 1}",
            percentCorrect: 0,
            isNew: false,
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
          "Speaking",
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
                    "Choose a speaking task",
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
