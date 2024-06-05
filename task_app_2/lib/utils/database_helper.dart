
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_app_2/model/section.dart';

class DatabaseHelper {
  static Database? _sectionDb;
  static DatabaseHelper? _databaseHelper;

  String table = 'sectionTable';
  String colId = 'id';
  String colModuleId = 'moduleid';
  String colAvailability = 'availability';
  String colInstance = "instance";
  String colModuleType = "moduletype";
  String colSectionTitle = "sectiontitle";
  String colSectionImage = 'sectionimage';

  DatabaseHelper._createInstance();

  static final DatabaseHelper db = DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_sectionDb == null) {
      _sectionDb = await initializeDatabase();
    }
    return _sectionDb!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'sections.db';
    var myDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return myDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $table"
        "($colId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$colModuleId TEXT, $colAvailability TEXT, $colInstance TEXT, $colModuleType TEXT, $colSectionTitle TEXT, $colSectionImage TEXT)");
  }

  Future<List<Map<String, dynamic>>> getSectionMapList() async {
    Database db = await this.database;
    var result = await db.query(table, orderBy: "$colId ASC");
    return result;
  }

  Future<int> insertSection(Section section) async {
    Database db = await this.database;
    var result = await db.insert(table, section.toMap());
    print(result);
    return result;
  }

  Future<int> updateProduct(Section section) async {
    var db = await this.database;
    var result = await db.update(table, section.toMap(),
        where: '$colId = ?', whereArgs: [section.moduleId]);
    return result;
  }

  Future<int> deleteSection(int id,) async {
    var db = await this.database;
    int result = await db
        .delete(table, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteAllSection() async {
    var db = await this.database;
    int result = await db
        .delete(table);
    return result;
  }

  Future<List<Section>> getSectionList() async {
    var sectionMapList = await getSectionMapList();
    int? count = await getCount(table);

    List<Section> sectionList = <Section>[];
    for (int i = 0; i < count!; i++) {
      sectionList.add(Section.fromMap(sectionMapList[i]));
    }
    return sectionList;
  }

  Future<int?> getCount(tableName) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $tableName');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  close() async {
    var db = await this.database;
    var result = db.close();
    return result;
  }
}
