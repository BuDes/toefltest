// lib/pages/listening_page.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toeflapp/models/section_model.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/widgets/section_card.dart';
import '../practice_detail_page.dart';

const Color primaryBlue = AppColors.primary;
const Color cream1 = Color(0xffF5EFE6);
const Color cream2 = Color(0xffE8DFCA);

class ListeningPage extends StatelessWidget {
  const ListeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream1,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 2,
        title: const Text(
          "Listening",
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
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: _ListeningContent(),
            ),
          ),
        ),
      ),
    );
  }
}

class _ListeningContent extends StatefulWidget {
  const _ListeningContent();
  @override
  State<_ListeningContent> createState() => _ListeningContentState();
}

class _ListeningContentState extends State<_ListeningContent> {
  // sample data
  final List<SectionData> sections = [
    SectionData(
      title: 'Conversations',
      icon: Icons.headphones,
      totalTests: 50,
      percentCorrect: 0,
      practices: List.generate(
        6,
        (i) => PracticeData(
          id: i + 1,
          title: 'Practice ${50 - i}',
          percentCorrect: 0,
          isNew: i < 3,
        ),
      ),
    ),
    SectionData(
      title: 'Lectures',
      icon: Icons.record_voice_over,
      totalTests: 50,
      percentCorrect: 0,
      practices: List.generate(
        5,
        (i) => PracticeData(
          id: i + 101,
          title: 'Lecture ${i + 1}',
          percentCorrect: (i + 1) * 0.1,
          isNew: i % 2 == 0,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        const Text(
          'Choose a section to start',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: primaryBlue,
          ),
        ),
        const SizedBox(height: 16),
        // render sections
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
    );
  }
}
