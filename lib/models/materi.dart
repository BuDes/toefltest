class Materi {
  final String id;
  final String nama;
  final String? videoFile;
  final String? content;
  final DateTime tanggal;

  Materi({
    required this.id,
    required this.nama,
    required this.videoFile,
    required this.content,
    required this.tanggal,
  });

  factory Materi.fromJson(Map<String, dynamic> json) {
    return Materi(
      id: json["id"],
      nama: json["nama"],
      videoFile: json["videoFile"],
      content: json["content"],
      tanggal: json["createdAt"],
    );
  }
}
