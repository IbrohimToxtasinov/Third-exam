import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:third_exam/data/models/main/cached.dart';

class LocalDatabase {
  static String tableName = "todoTable";
  static LocalDatabase getInstance = LocalDatabase._init();
  Database? _database;

  LocalDatabase._init();

  Future<Database> getDb() async {
    if (_database == null) {
      _database = await _initDB("todo.db");
      return _database!;
    }
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, fileName);

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
        String textType = "TEXT";
        String intType = "INTEGER";
        String boolType = "INTEGER";

        await db.execute('''
        CREATE TABLE $tableName (
            ${ProductFields.id} $idType,
            ${ProductFields.count} $intType, 
            ${ProductFields.category_id} $intType, 
            ${ProductFields.name} $textType, 
            ${ProductFields.price} $intType,
            ${ProductFields.image_url} $textType,
            ${ProductFields.description} $textType
            )
            ''');
      },
    );
    return database;
  }

  static Future<ProductModel> insertToDatabase(ProductModel newTodo) async {
    var database = await getInstance.getDb();
    int id = await database.insert(tableName, newTodo.toJson());
    print("HAMMASI YAXSHI");
    return newTodo.copyWith(id: id);
  }

  static Future<ProductModel> updateTaskById(ProductModel updatedTask) async {
    var database = await getInstance.getDb();
    int id = await database.update(
      tableName,
      updatedTask.toJson(),
      where: 'id = ?',
      whereArgs: [updatedTask.id],
    );
    print("HAMMASI YAXSHI");
    return updatedTask.copyWith(id: id);
  }

  static Future<List<ProductModel>> getList() async {
    var database = await getInstance.getDb();
    var listOfTodos = await database.query(tableName, columns: [
        ProductFields.id,
        ProductFields.count,
        ProductFields.category_id,
        ProductFields.name,
        ProductFields.price,
        ProductFields.image_url,
        ProductFields.description,
    ]);

    var list = listOfTodos.map((e) => ProductModel.fromJson(e)).toList();

    return list;
  }

  static Future<List<ProductModel>> getTaskByTitle({String title = ''}) async {
    var database = await getInstance.getDb();

    if (title.isNotEmpty) {
      var listOfTodos = await database.query(
        tableName,
        where: 'title LIKE ?',
        whereArgs: ['%$title%'],
      );
      var list = listOfTodos.map((e) => ProductModel.fromJson(e)).toList();
      return list;
    } else {
      var listOfTodos = await database.query(tableName, columns: [
        ProductFields.id,
        ProductFields.count,
        ProductFields.category_id,
        ProductFields.name,
        ProductFields.price,
        ProductFields.image_url,
        ProductFields.description,
      ]);

      var list = listOfTodos.map((e) => ProductModel.fromJson(e)).toList();
      return list;
    }
  }

  static Future<int> deleteTaskById(int id) async {
    var database = await getInstance.getDb();
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  static Future<int> deleteAll() async {
    var database = await getInstance.getDb();
    return await database.delete(
      tableName
    );
  }
}