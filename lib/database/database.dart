import 'dart:io';
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

  Future<List<CityModel>> getCityListFromTable() async {
    List<CityModel> cityList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data =
        await db.rawQuery("Select * from Mst_City");
    CityModel model = CityModel();
    model.CityID = -1;
    model.CityName = "Select City";
    for (int i = 0; i < data.length; i++) {
      model = CityModel();
      model.CityID = data[i]["CityID"] as int;
      model.CityName = data[i]["CityName"].toString();
      model.StateID = data[i]["StateID"] as int;
      cityList.add(model);
    }
    // print("data length : ${data.length}");
    return cityList;
  }
}

// Future<List<Map<String, Object?>>>
