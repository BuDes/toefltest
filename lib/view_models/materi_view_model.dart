import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toeflapp/models/jenis_materi.dart';
import 'package:toeflapp/models/materi.dart';
import 'package:toeflapp/services/api_service.dart';

class MateriViewModel extends ChangeNotifier {
  final _endpoint = "${ApiService.baseUrl}/materi";
  final _jenisEndpoint = "${ApiService.baseUrl}/jenis_materi";
  final _favoritesKey = "FAVORITES";

  List<JenisMateri> _jenis = [];
  List<Materi> currentMateri = [];

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

  Future<List<Materi>> getMateriByJenis(String idJenis) async {
    try {
      final response = await ApiService.getRequest("$_endpoint/$idJenis");
      if (response.statusCode < 300) {
        final json = response.data as List;
        return json.map((e) => Materi.fromJson(e)).toList();
      }
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      rethrow;
    }
  }

  Future<bool> isFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList(_favoritesKey) ?? [];
    return favs.contains((id));
  }

  Future toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList(_favoritesKey) ?? [];
    if (await isFavorite(id)) {
      favs.remove(id);
    } else {
      favs.add(id);
    }
    await prefs.setStringList(_favoritesKey, favs);
  }

  Materi? nextMateri(Materi materi) {
    final index = currentMateri.indexOf(materi);
    if (index == -1) return null;
    if (currentMateri.length == index + 1) return null;
    return currentMateri[index + 1];
  }
}
