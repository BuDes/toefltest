import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

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
        // TODO: migrate pesan table;;
      },
    );
  }
}
