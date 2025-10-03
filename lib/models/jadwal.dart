class Jadwal {
  final String id;
  final String nama;
  final DateTime tanggal;

  Jadwal({
    required this.id,
    required this.nama,
    required this.tanggal,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      id: json["id"],
      nama: json["nama"],
      tanggal: DateTime.parse(json["tanggal"]),
    );
  }
}
