import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:poc_flutter_app/models/stuClass.dart';

import '../models/userModel.dart';

class Dbase{

  static final _databaseName = "stu.db";
  static final _databaseVersion = 1;
 
  static final table = 'stu';
  static final table_user = 'user';
 
  static final columnId = 'id';
  static final columnName = 'name';
  static final columnClgName= 'clgname';
  static final columnBranch = 'branch';
  static final columnYear = 'year';

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';
 
  Dbase._privateConstructor();
  static final Dbase instance = Dbase._privateConstructor();
 
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }
 
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }
 
  Future _onCreate(Database db, int version) async {

    await db.execute("CREATE TABLE $table_user ("
        " $C_UserID  INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT, "
        // " PRIMARY KEY ($C_UserID)"
        "FOREIGN KEY ($C_UserID) REFERENCES $table($C_UserID)"
        ")");

    await db.execute("CREATE TABLE $table ("
        // " $columnId INTEGER, "
        "$C_UserID INTEGER"
        " $columnName STRING, "
        " $columnClgName STRING,"
        " $columnBranch STRING, "
        "$columnYear INTEGER NOT NULL"
        " PRIMARY KEY ($C_UserID)"
        ")");

    // await db.execute('CREATE TABLE $table('
    //     "id STRING PRIMARY KEY,name STRING, clgname STRING, branch STRING, year INTEGER NOT NULL'
    //   ')');

  }
  
  Future<int?> saveData(UserModel user) async {
    Database? db = await instance.database;
    var res = await db?.insert(table_user, user.toMap());
    return res;
    // var dbClient = await _database;
    // var res = await dbClient?.insert(table_user, user.toMap());
    // return res;
  }

  Future<UserModel?> getLoginUser(String userName, String password) async {
    var dbClient = await _database;
    var res = await dbClient?.rawQuery("SELECT * FROM $table_user WHERE "
        "$C_UserName = '$userName' AND "
        "$C_Password = '$password'");

    if (res!.isNotEmpty) {
      return UserModel.fromMap(res.first);
    }
    return null;
  }

  Future<int?> insert(StuClass todo) async {
    Database? db = await instance.database;
    var res = await db?.insert(table, todo.toMap());
    return res;
  }
 
  Future<List<Map<String, dynamic>>?> queryAllRows() async {
    Database? db = await instance.database;
    var res = await db?.query(table, orderBy: "$columnId DESC");
    return res;
  }
 
  Future<int?> delete(int id) async {
    Database? db = await instance.database;
    return await db?.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
 
  Future<List<Map<String, Object?>>?> clearTable() async {
    Database? db = await instance.database;
    return await db?.rawQuery("DELETE FROM $table");
  }

}
