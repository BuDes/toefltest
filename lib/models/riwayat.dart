import 'package:intl/intl.dart';
import 'package:toeflapp/models/jadwal.dart';
import 'package:toeflapp/models/materi.dart';

class Riwayat {
  final String id;
  final Materi? materi;
  final Jadwal? jadwal;

  Riwayat({
    required this.id,
    required this.materi,
    required this.jadwal,
  });

  String get tanggal {
    final date = materi?.tanggal ?? jadwal?.tanggal;
    if (date == null) return "";

    final timeFormatter = DateFormat("HH:mm");
    final dateFormatter = DateFormat("dd/MM/yy");
    final today = DateTime.now();
    final formatter = _isSameDay(today, date) ? timeFormatter : dateFormatter;
    return formatter.format(date);
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  factory Riwayat.fromJson(Map<String, dynamic> json) {
    return Riwayat(
      id: json["id"],
      materi: Materi.fromJson(json["materi"]),
      jadwal: Jadwal.fromJson(json["jadwal_test"]),
    );
  }
}
