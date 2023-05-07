import 'package:sqflite/sqflite.dart';


final String TableName = 'Items';


class basketItems {
  final int id;
  final String gubun;

  basketItems({required this.id,required this.gubun});
}




initDB() async {
  return await openDatabase(
      './db/basket.db',
      version: 2,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE $TableName(no INTEGER PRIMARY KEY AUTOINCREMENT, id INTEGER,gubun TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion){}
  );
}


//Create
addData(int id, String gubun) async {
  final db = await initDB();
  var res = await db.rawInsert('INSERT INTO $TableName(id,gubun) VALUES(?,?)',[id,'$gubun']);
  return res;
}

//Read All
Future<List<basketItems>> getAllItems() async {
  final db = await initDB();
  var res = await db.rawQuery('SELECT id,gubun FROM $TableName where gubun != "C"');
  List<Map<String,dynamic>> list = res;

  if(list.length == 0) return [];
  return List.generate(list.length, (i) {
    return basketItems(
      id: list[i]['id'],
      gubun: list[i]['gubun'],
    );
  });
}

Future<List<basketItems>> getAllCItems() async {
  final db = await initDB();
  var res = await db.rawQuery('SELECT id,gubun FROM $TableName where gubun == "C"');
  List<Map<String,dynamic>> list = res;

  if(list.length == 0) return [];
  return List.generate(list.length, (i) {
    return basketItems(
      id: list[i]['id'],
      gubun: list[i]['gubun'],
    );
  });
}
//Delete
deleteItem(int id) async {
  final db = await initDB();
  var res = db.rawDelete('DELETE FROM $TableName WHERE id = ?', [id]);
  return res;
}

//Delete All
deleteAllItems() async {
  final db = await initDB();
  db.rawDelete('DELETE FROM $TableName');
}