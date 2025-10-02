class JenisMateri {
  final String id;
  final String nama;
  final String gambar;
  final String deskripsi;

  JenisMateri({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.deskripsi,
  });

  factory JenisMateri.fromJson(Map<String, dynamic> json) {
    return JenisMateri(
      id: json["id"],
      nama: json["nama"],
      gambar: json["gambar"],
      deskripsi: json["deskripsi"],
    );
  }
}
