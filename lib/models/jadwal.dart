import 'package:intl/intl.dart';

class Jadwal {
  final String id;
  final String nama;
  final DateTime tanggal;

  Jadwal({
    required this.id,
    required this.nama,
    required this.tanggal,
  });

  String get scheduleInfo {
    return "$tanggalString $jamString";
  }

  String get tanggalString {
    return DateFormat("dd MMM yyyy").format(tanggal);
  }

  String get jamString {
    return DateFormat("HH.mm").format(tanggal);
  }

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      id: json["id"],
      nama: json["nama"],
      tanggal: DateTime.parse(json["tanggal"]).toLocal(),
    );
  }
}
