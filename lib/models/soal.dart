class Soal {
  final String id;
  final String pertanyaan;
  final String idOpsiBenar;
  final List<Opsi> opsi;
  final Attachment? attachment;

  Soal({
    required this.id,
    required this.pertanyaan,
    required this.idOpsiBenar,
    required this.opsi,
    required this.attachment,
  });

  factory Soal.fromJson(Map<String, dynamic> json) {
    final opsi = json["opsi"] as List;
    final attachment = json["attachment"];

    return Soal(
      id: json["id"],
      pertanyaan: json["pertanyaan"],
      idOpsiBenar: json["idOpsiBenar"],
      opsi: opsi.map((e) => Opsi.fromJson(e)).toList(),
      attachment: attachment != null ? Attachment.fromJson(attachment) : null,
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

class Attachment {
  final String id;
  final String? passage;
  final String? audioFile;

  Attachment({
    required this.id,
    required this.passage,
    required this.audioFile,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json["id"],
      passage: json["passage"],
      audioFile: json["audioFile"],
    );
  }
}
