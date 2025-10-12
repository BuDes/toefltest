import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:toeflapp/models/hasil_jawaban.dart';
import 'package:toeflapp/models/test_section.dart';
import 'package:toeflapp/services/api_service.dart';

class TestViewModel extends ChangeNotifier {
  final _soalEndpoint = "${ApiService.baseUrl}/soal";
  final _riwayatEndpoint = "${ApiService.baseUrl}/riwayat";

  Future<List<TestSection>?> getPracticeTest() async {
    try {
      final response = await ApiService.getRequest(
        "$_soalEndpoint/practice_test",
      );
      if (response.statusCode < 300) {
        final json = response.data as List;
        final sections = json.map((e) => TestSection.fromJson(e)).toList();
        return sections;
      }
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      return null;
    }
  }

  Future<String?> submitAnswers(Map<String, String?> answers) async {
    try {
      final answersList = List.generate(answers.length, (index) {
        final idSoal = answers.keys.toList()[index];
        final idOpsi = answers.values.toList()[index];
        return {
          "idSoal": idOpsi == null ? idSoal : null,
          "idOpsi": idOpsi,
        };
      });
      final response = await ApiService.postRequest(
        "$_riwayatEndpoint/submit_jawaban",
        body: jsonEncode({"jawaban": answersList}),
      );
      if (response.statusCode < 300) {
        return null;
      }
      return response.message;
    } catch (e, stacktrace) {
      log("Failed to login: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }

  Future<List<HasilJawaban>?> hasilPracticeTest() async {
    try {
      final response = await ApiService.getRequest(
        "$_riwayatEndpoint/hasil_practice_test",
      );
      if (response.statusCode < 300) {
        final json = response.data as List;
        final sections = json.map((e) => HasilJawaban.fromJson(e)).toList();
        return sections;
      }
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      return null;
    }
  }
}
