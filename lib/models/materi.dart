// models/materi.dart
class Materi {
  final String id;
  final String nama;
  final String? videoFile;
  final String? audioFile;
  final String? documentFile;
  final String content;
  final DateTime tanggal;
  final String kategori;
  final String level;
  final int estimatedMinutes;
  final List<String> tags;
  final bool hasExercise;

  Materi({
    required this.id,
    required this.nama,
    this.videoFile,
    this.audioFile,
    this.documentFile,
    required this.content,
    required this.tanggal,
    required this.kategori,
    required this.level,
    this.estimatedMinutes = 15,
    this.tags = const [],
    this.hasExercise = false,
  });

  factory Materi.fromJson(Map<String, dynamic> json) {
    return Materi(
      id: json["id"],
      nama: json["nama"],
      videoFile: json["videoFile"],
      audioFile: json["audioFile"],
      documentFile: json["documentFile"],
      content: json["content"],
      tanggal: DateTime.parse(json["tanggal"]),
      kategori: json["kategori"],
      level: json["level"],
      estimatedMinutes: json["estimatedMinutes"] ?? 15,
      tags: List<String>.from(json["tags"] ?? []),
      hasExercise: json["hasExercise"] ?? false,
    );
  }
}