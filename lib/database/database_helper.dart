import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //Singleton Database Instance
  static Database? _db;

  //Database Accessor - Provides async access to the database
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  //Database Initialization
  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'portfolio.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  //Table Creation
  Future<void> onCreate(Database db, int version) async {
    await db.execute(
      ''' CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, email TEXT NOT NULL UNIQUE, password TEXT NOT NULL)''',
    );
  }

  //sign up user
  Future<int?> signup(String username, String email, String password) async {
    var client = await db;

    //check if user already exists
    List<Map<String, dynamic>> result = await client.query(
      'users',
      where: 'email =? AND password=?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      //already exists
      return null;
    }

    //Insert new user
    return await client.insert('users', {
      'username': username,
      'email': email,
      'password': password,
    });
  }

  //sign in user
  Future<Map<String, dynamic>?> signIn(String email, String password) async {
    var client = await db;

    List<Map<String, dynamic>> result = await client.query(
      'users',
      where: 'email =? AND password=?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  //check is user exists by email
  Future<bool> checkUserExist(String email) async {
    var client = await db;
    List<Map<String, dynamic>> result = await client.query(
      'users',
      where: 'email=?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  //close database/ database cleanup
  Future<void> closeDatabase() async {
    var client = await db;
    await client.close();
  }
}
