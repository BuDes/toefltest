import 'dart:convert';

class NewUser {
  final String nama;
  final String email;
  final String password;

  NewUser({
    required this.nama,
    required this.email,
    required this.password,
  });

  String toJson() {
    return jsonEncode({
      "nama": nama,
      "email": email,
      "password": password,
    });
  }
}
