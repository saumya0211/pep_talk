import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;

class dbHelper{

  static Future<sql.Database> DataBase() async{
    return await sql.openDatabase(p.join(await sql.getDatabasesPath(),'Place_Depository.db'),
        onCreate: (db, ver) {
       db.execute("CREATE TABLE placestore(id TEXT PRIMARY KEY, title TEXT, video TEXT, thumbnail TEXT, lat DOUBLE, long DOUBLE ,address TEXT)");
    },version: 1);

  }
  static Future<void> insert(String Table,Map<String,Object> data) async{
    final db = await dbHelper.DataBase();
    db.insert(
        Table,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
  static Future<List<Map<String,dynamic>>> getData(String table) async{
    final db = await dbHelper.DataBase();
    return db.query(table);
  }

}