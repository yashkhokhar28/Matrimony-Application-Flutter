import 'dart:io';
import 'package:matrimony/model/user_model.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/city_model.dart';

class MyDatabase {
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

  Future<void> upsertIntoUserTable({cityID, userName, dob, userID}) async {
    Database db = await initDatabase();
    Map<String, Object> map = Map();
    map["Name"] = userName;
    map["DOB"] = dob;
    map["CityID"] = cityID;
    if (userID != -1) {
      // map["UserID"] = userID;
      await db
          .update("Tbl_User", map, where: "UserID = ?", whereArgs: [userID]);
    } else {
      await db.insert("Tbl_User", map);
    }
  }

  Future<List<CityModel>> getCityListFromTable() async {
    List<CityModel> cityList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data =
        await db.rawQuery("Select * from Mst_City");
    CityModel model =
        CityModel(CityID1: -1, CityName1: "Select City", StateID1: -1);
    cityList.add(model);
    for (int i = 0; i < data.length; i++) {
      model = CityModel(
          CityID1: data[i]["CityID"] as int,
          CityName1: data[i]["CityName"].toString(),
          StateID1: data[i]["StateID"] as int);
      cityList.add(model);
    }
    return cityList;
  }

  Future<List<UserModel>> getUserListFromTable() async {
    List<UserModel> userList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data =
        await db.rawQuery("Select * from Tbl_User");
    for (int i = 0; i < data.length; i++) {
      UserModel model = UserModel();
      model.CityID = data[i]["CityID"] as int;
      model.UserID = data[i]["UserID"] as int;
      model.Name = data[i]["Name"].toString();
      model.DOB = data[i]["DOB"].toString();
      model.isFavouriteUser = false;
      userList.add(model);
    }
    return userList;
  }

  Future<int> deleteUserFromUserTable(userID) async {
    Database db = await initDatabase();
    int deletedid = await db.delete(
      'Tbl_User',
      where: 'UserID = ?',
      whereArgs: [userID],
    );
    return deletedid;
  }

  Future<bool> updateIsFavourite(userID,isFavourite) async {
    Database db = await initDatabase();
    Map<String, Object?> map = Map();
    map['IsFavourite'] = !isFavourite;
    db.update('Tbl_User', map,where: 'UserID = ?', whereArgs: [userID],);
    return true;

  }
}

