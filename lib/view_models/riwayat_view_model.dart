import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:toeflapp/models/riwayat.dart';
import 'package:toeflapp/services/api_service.dart';

class RiwayatViewModel extends ChangeNotifier {
  final _endpoint = "${ApiService.baseUrl}/riwayat";

  List<Riwayat> _riwayat = [];

  List<Riwayat> get top3 {
    if (riwayat.length < 3) return riwayat;
    return riwayat.sublist(0, 3);
  }

  List<Riwayat> get riwayat => _riwayat;

  int get jlhMateri {
    return _riwayat.where((e) => e.materi != null).length;
  }

  int get jlhTest {
    return _riwayat.where((e) => e.jadwal != null).length;
  }

  Future<String?> getRiwayat() async {
    try {
      final response = await ApiService.getRequest(_endpoint);
      if (response.statusCode < 300) {
        final json = response.data as List;
        _riwayat = json.map((e) => Riwayat.fromJson(e)).toList();
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
