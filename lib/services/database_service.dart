import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'dart:developer';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'berlingvo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        //-----/ Migrate Pesan Table /-----//
        await db.execute("""
          CREATE TABLE pesan (
            id VARCHAR PRIMARY KEY NOT NULL,
            isi VARCHAR NOT NULL,
            status VARCHAR NOT NULL,
            id_pengirim VARCHAR NOT NULL,
            id_penerima VARCHAR NOT NULL,
            timestamp INTEGER NOT NULL,
            tgl_baca INTEGER
          )
        """);

        //-----/ Migrate Users Table /-----//
        await db.execute("""
          CREATE TABLE users (
            id VARCHAR PRIMARY KEY NOT NULL,
            email VARCHAR NOT NULL,
            nama VARCHAR NOT NULL
          )
        """);
      },
    );
  }

  //-------/ Pesan /-------/
  Future<List<Map<String, dynamic>>> getPesan() async {
    final db = await database;
    return await db.query("pesan", orderBy: "timestamp DESC");
  }

  Future savePesan(List<Map<String, dynamic>> listPesan) async {
    try {
      final db = await database;
      await Future.wait(
        listPesan.map((pesan) {
          final cols = pesan.keys.join(", ");
          final placeholders = pesan.keys.map((_) => "?").join(", ");
          final sql =
              """
          INSERT INTO pesan ($cols) VALUES ($placeholders)
        """;
          return db.rawInsert(sql, pesan.values.toList());
        }),
      );
    } catch (e) {
      log("Failed to save pesan: $e");
    }
  }

  Future<int> readPesan(String idPengirim, int time) async {
    final db = await database;
    return db.rawUpdate(
      "UPDATE pesan SET tgl_baca=$time WHERE id_pengirim='$idPengirim' AND tgl_baca IS NULL",
    );
  }

  Future<int> clearPesan() async {
    final db = await database;
    return db.delete("pesan");
  }

  //-------/ Users /-------/
  Future saveUsers(List<Map<String, dynamic>> listUser) async {
    try {
      final db = await database;
      await Future.wait(
        listUser.map((user) async {
          final existing = await db.query(
            "users",
            where: "id=?",
            whereArgs: [user["id"]],
          );
          if (existing.isEmpty) await db.insert("users", user);
        }),
      );
    } catch (e) {
      log("Failed to save users: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query("users");
  }

  Future<int> clearUsers() async {
    final db = await database;
    return db.delete("users");
  }
}
