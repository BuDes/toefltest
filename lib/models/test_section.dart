import 'package:toeflapp/models/soal.dart';

class TestSection {
  final String nama;
  final int jlhSoal;
  final List<Soal> soal;

  TestSection({
    required this.nama,
    required this.jlhSoal,
    required this.soal,
  });

  factory TestSection.fromJson(Map<String, dynamic> json) {
    final soal = json["soal"] as List;

    return TestSection(
      nama: json["nama"],
      jlhSoal: json["jlhSoal"],
      soal: soal.map((e) => Soal.fromJson(e)).toList(),
    );
  }
}
