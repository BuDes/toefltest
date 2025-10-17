import 'package:intl/intl.dart';
import 'package:toeflapp/models/jadwal.dart';
import 'package:toeflapp/models/materi.dart';

class Riwayat {
  final String id;
  final Materi? materi;
  final Jadwal? jadwal;
  final DateTime createdAt;

  Riwayat({
    required this.id,
    required this.materi,
    required this.jadwal,
    required this.createdAt,
  });

  String get tanggal {
    final date = materi?.tanggal ?? jadwal?.tanggal;
    final timeFormatter = DateFormat("HH:mm");
    final dateFormatter = DateFormat("dd/MM/yy");
    final today = DateTime.now();

    if (date == null) {
      final formatter = _isSameDay(today, createdAt)
          ? timeFormatter
          : dateFormatter;
      return formatter.format(createdAt);
    }

    final formatter = _isSameDay(today, date) ? timeFormatter : dateFormatter;
    return formatter.format(date);
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  factory Riwayat.fromJson(Map<String, dynamic> json) {
    final materi = json["materi"];
    final jadwal = json["jadwal_test"];
    final createdAt = json["createdAt"];

    return Riwayat(
      id: json["id"],
      materi: materi != null ? Materi.fromJson(materi) : null,
      jadwal: jadwal != null ? Jadwal.fromJson(jadwal) : null,
      createdAt: DateTime.parse(createdAt).toLocal(),
    );
  }
}
