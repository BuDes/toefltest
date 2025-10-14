class ChatMessage {
  String? id;
  final String isi;
  StatusPesan status;
  final DateTime waktuKirim;
  final String idPengirim;
  final String idPenerima;
  final DateTime? tglBaca;

  ChatMessage({
    required this.id,
    required this.isi,
    required this.status,
    required this.waktuKirim,
    required this.idPengirim,
    required this.idPenerima,
    this.tglBaca,
  });

  bool isPengirim(String id) => id == idPengirim;

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json["id"],
      isi: json["content"],
      status: StatusPesan.dikirim,
      waktuKirim: DateTime.parse(json["createdAt"]),
      idPengirim: json["fromUserId"],
      idPenerima: json["toUserId"],
    );
  }

  factory ChatMessage.fromDatabase(Map<String, dynamic> json) {
    final tglBaca = json["tgl_baca"] != null
        ? DateTime.fromMillisecondsSinceEpoch(json["tgl_baca"])
        : null;
    final status = StatusPesan.values.firstWhere((e) {
      return e.name == json["status"];
    });
    return ChatMessage(
      id: json["id"],
      isi: json["isi"],
      idPengirim: json["id_pengirim"],
      idPenerima: json["id_penerima"],
      status: status,
      waktuKirim: DateTime.fromMillisecondsSinceEpoch(json["timestamp"]),
      tglBaca: tglBaca,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "isi": isi,
      "status": status.name,
      "timestamp": waktuKirim.millisecondsSinceEpoch,
      "id_pengirim": idPengirim,
      "id_penerima": idPenerima,
      "tgl_baca": tglBaca?.millisecondsSinceEpoch,
    };
  }
}

enum StatusPesan { pending, dikirim, dibaca, error }
