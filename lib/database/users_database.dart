import 'package:field_management/database/users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();
  static Database? _database;
  UserDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTGER PRIMARY KEY";
    const textType = "TEXT NOT NULL";
    const integerType = "INTEGER NOT NULL";

    await db.execute("""
CREATE TABLE $tableUsers (
  ${UsersFields.id} $idType, ${UsersFields.name} $textType,
  ${UsersFields.age} $integerType
)
""");
  }

  Future<Users> addUser(Users users) async {
    final db = await instance.database;
    final id = await db.insert(tableUsers, users.toJson());
    return users.copy(id: id);
  }

  Future<Users> readUser(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableUsers,
      columns: UsersFields.values,
      where: '${UsersFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Users.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Users>> readAllUsers() async {
    final db = await instance.database;

    const orderBy = '${UsersFields.name} ASC';
    final result = await db.query(tableUsers, orderBy: orderBy);
    return result.map((json) => Users.fromJson(json)).toList();
  }

  Future<int> updateUser(Users users) async {
    final db = await instance.database;
    return db.update(
      tableUsers,
      users.toJson(),
      where: '${UsersFields.id} = ?',
      whereArgs: [users.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return db.delete(
      tableUsers,
      where: '${UsersFields.id}= ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
