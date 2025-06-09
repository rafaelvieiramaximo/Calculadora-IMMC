import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper.internal();
  Database? internal;

  factory DataBaseHelper() {
    return instance;
  }

  DataBaseHelper.internal();

  Future<Database> get database async {
    if (internal != null) return internal!;
    internal = await initDataBase();
    return internal!;
  }

  Future<Database> initDataBase() async {
    final path = join(await getDatabasesPath(), 'user_database.db');

    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT, name TEXT, lastname TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(
    String email,
    String password,
    String name,
    String lastname,
  ) async {
    final db = await database;
    await db.insert('users', {
      'email': email,
      'password': password,
      'name': name,
      'lastname': lastname,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String> getName(String email) async {
    final user = await getUser(email);
    return user?['name'] ?? '';
  }

  // Future<void> clearUsers() async {
  //   final db = await database;
  //   await db.delete('users');
  // }

  Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }
}
