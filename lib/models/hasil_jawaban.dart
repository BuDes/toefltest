import 'dart:convert';
import 'dart:developer';

import 'package:toeflapp/models/soal.dart';

class HasilJawaban {
  final String? idOpsi;
  final List<Opsi> opsi;
  final String idOpsiBenar;
  final String pertanyaan;
  final String pembahasan;

  HasilJawaban({
    required this.idOpsi,
    required this.opsi,
    required this.idOpsiBenar,
    required this.pertanyaan,
    required this.pembahasan,
  });

  bool get isBenar => idOpsiBenar == idOpsi;

  factory HasilJawaban.fromJson(Map<String, dynamic> json) {
    final opsi = json["opsi"] as List;
    log(jsonEncode(json));

    return HasilJawaban(
      idOpsi: json["idOpsi"],
      opsi: opsi.map((e) => Opsi.fromJson(e)).toList(),
      idOpsiBenar: json["idOpsiBenar"],
      pertanyaan: json["pertanyaan"],
      pembahasan: json["pembahasan"],
    );
  }
}
