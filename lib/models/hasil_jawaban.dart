import 'package:toeflapp/models/soal.dart';

class HasilJawaban {
  final String? idOpsi;
  final List<Opsi> opsi;
  final String idOpsiBenar;
  final String pertanyaan;

  HasilJawaban({
    required this.idOpsi,
    required this.opsi,
    required this.idOpsiBenar,
    required this.pertanyaan,
  });

  bool get isBenar => idOpsiBenar == idOpsi;

  factory HasilJawaban.fromJson(Map<String, dynamic> json) {
    final opsi = json["opsi"] as List;

    return HasilJawaban(
      idOpsi: json["idOpsi"],
      opsi: opsi.map((e) => Opsi.fromJson(e)).toList(),
      idOpsiBenar: json["idOpsiBenar"],
      pertanyaan: json["pertanyaan"],
    );
  }
}
