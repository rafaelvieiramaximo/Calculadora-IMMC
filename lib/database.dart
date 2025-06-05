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
    return openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)',
        );
      },
      version: 1, //Essa versão é importante para controle de migrações
    );
  }

  Future<void> insertsUser(String email, String password) async {
    final db = await database;
    await db.insert('users', {
      'email': email,
      'password': password,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

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
