import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:toeflapp/models/jenis_materi.dart';
import 'package:toeflapp/services/api_service.dart';

class MateriViewModel extends ChangeNotifier {
  final _endpoint = "${ApiService.baseUrl}/materi";
  final _jenisEndpoint = "${ApiService.baseUrl}/jenis_materi";

  List<JenisMateri> _jenis = [];
  List<JenisMateri> get jenis => _jenis;

  Future<String?> getJenisMateri() async {
    try {
      final response = await ApiService.getRequest(_jenisEndpoint);
      if (response.statusCode < 300) {
        final json = response.data as List;
        _jenis = json.map((e) => JenisMateri.fromJson(e)).toList();
        notifyListeners();
        return null;
      }
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }
}
