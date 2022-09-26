import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuranDB{
  static Database? database ;
  static initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath,"quran.db");
    bool exist = await databaseExists(path);
    print(exist);
    if(!exist){
      //copy data base and must await coz of future
    await copyDB(path);
    }
    // if exist open it
     database = await openDatabase(path);

  }
// we will copy
  static copyDB(path) async {
    ByteData  fileData = await rootBundle.load(join("assets","quran.db"));
    List<int> bytesList = fileData.buffer.asUint8List(fileData.offsetInBytes,fileData.lengthInBytes);
     await  File(path).writeAsBytes(bytesList);
     print("done");
  }
  static Future<List<Map>> retrieve()async{
     var data =  await database!.query("sora");
    // print(data);
     return data;
  }
  static Future<List<Map>> retrieveAyat( int id)async{
    var data =  await database!.query("aya",where: "soraid=?",whereArgs: [id] );
    return data;
  }
}