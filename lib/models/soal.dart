class Soal {
  final String id;
  final String pertanyaan;
  final String idOpsiBenar;
  final List<Opsi> opsi;

  Soal({
    required this.id,
    required this.pertanyaan,
    required this.idOpsiBenar,
    required this.opsi,
  });

  factory Soal.fromJson(Map<String, dynamic> json) {
    final opsi = json["opsi"] as List;

    return Soal(
      id: json["id"],
      pertanyaan: json["pertanyaan"],
      idOpsiBenar: json["idOpsiBenar"],
      opsi: opsi.map((e) => Opsi.fromJson(e)).toList(),
    );
  }
}

class Opsi {
  final String id;
  final String isi;

  Opsi({
    required this.id,
    required this.isi,
  });

  factory Opsi.fromJson(Map<String, dynamic> json) {
    return Opsi(
      id: json["id"],
      isi: json["isi"],
    );
  }
}
