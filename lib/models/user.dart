class User {
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["nama"],
      email: json["email"],
    );
  }

  factory User.fromDatabase(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      name: json["nama"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nama": name,
      "email": email,
    };
  }
}
