import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'matrimony.db');
    return await openDatabase(
      databasePath,
      version: 2,
    );
  }

  Future<void> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "matrimony.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
      await rootBundle.load(join('assets/database', 'matrimony.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);
    }
  }

  Future<List<Map<String, Object?>>> getAllFromUserTable() async {
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery("select * from UserInfo");
    return data;
  }
  Future<void> insertIntoTable({userName,userSurname,userAge,userId}) async {
    Database db = await initDatabase();
    Map<String,Object?> map = Map();
    map["UserName"] = userName;
    map["UserSurname"] = userSurname;
    map["UserAge"] = userAge;
    if(userId!=null) {
      map["UserInfo_id"] = userId;
      await db.update("UserInfo", map,where: "UserInfo_id = ?",whereArgs: [userId]);
    }
    else{
      await db.insert("UserInfo", map);
    }
  }
  Future<void> deleteFromTable({userId}) async {
    Database db = await initDatabase();
    await db.rawQuery("delete from UserInfo where UserInfo_id=$userId");
  }
}