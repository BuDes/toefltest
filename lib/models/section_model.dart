// lib/models/section_model.dart
import 'package:flutter/material.dart';

class SectionData {
  final String title;
  final IconData icon;
  final int totalTests;
  final double percentCorrect; // 0..1
  final List<PracticeData> practices;

  SectionData({
    required this.title,
    required this.icon,
    required this.totalTests,
    required this.percentCorrect,
    required this.practices,
  });
}

class PracticeData {
  final int id;
  final String title;
  final double percentCorrect;
  final bool isNew;

  PracticeData({
    required this.id,
    required this.title,
    required this.percentCorrect,
    this.isNew = false,
  });
}
