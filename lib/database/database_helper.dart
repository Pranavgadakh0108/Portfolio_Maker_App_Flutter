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

    await db.execute('''
      CREATE TABLE profile(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_photo TEXT, full_name TEXT, profession TEXT, bio TEXT, mobile_number TEXT, address TEXT, linkedin TEXT, github TEXT, instagram TEXT, twitter TEXT, skills TEXT, ratings TEXT, degree TEXT, college TEXT, start_year TEXT, end_year TEXT, experience TEXT, achievement TEXT, has_experience TEXT, job_title TEXT, company_name TEXT, start_date TEXT, end_date TEXT, company_location TEXT, responsibilities TEXT, project_title TEXT, project_description TEXT, project_techstack TEXT, project_url TEXT, project_img TEXT, have_certificate TEXT, certificate_name TEXT, organization_name TEXT, issue_date TEXT, certificate_url TEXT, certificate_description TEXT, have_award TEXT, award_name TEXT, award_org_name TEXT, award_isu_date TEXT, award_desc TEXT, hobbies TEXT, availability TEXT, contact_method TEXT, cover_letter TEXT)
    ''');
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

  Future<int> insertProfile(Map<String, dynamic> profile) async {
    var client = await db;
    return client.insert('profile', profile);
  }

  Future<List<Map<String, dynamic>>> getAllProfiles() async {
    var client = await db;
    return client.query('profile');
  }

  Future<Map<String, dynamic>?> getProfileById(int id) async {
    var client = await db;
    final result = await client.query(
      'profile',
      where: 'id=?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> updateProfile(int id, Map<String, dynamic> updateProfile) async {
    var client = await db;
    return client.update(
      'profile',
      updateProfile,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  Future<int> deleteProfile(int id) async {
    var client = await db;
    return client.delete('profile', where: 'id=?');
  }

  //close database/ database cleanup
  Future<void> closeDatabase() async {
    var client = await db;
    await client.close();
  }
}
