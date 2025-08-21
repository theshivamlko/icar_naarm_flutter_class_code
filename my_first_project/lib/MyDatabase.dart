import 'dart:convert';

import 'package:sqflite/sqflite.dart';

class MyDatabase {
  Database? database;

  Future initialize() async {
    database = await openDatabase("mydb.db");

    database!.execute(
      """CREATE TABLE IF NOT EXISTS agriculture (index_name text PRIMARY KEY,title text,org_type text,
sector text,field text,records text) """,
    );
  }

  void insertData(
    String index_name,
    String title,
    String org_type,
    String sector,
    String field,
    String records,
  ) async {
    await database!.insert("agriculture", {
      "index_name": index_name,
      "title": title,
      "org_type": org_type,
      "sector": sector,
      "field": field,
      "records": records,
    });
  }

  Future<Map<String, dynamic>> readData() async {
    List<Map<String, dynamic>> rows = await database!.rawQuery(
      "SELECT * FROM agriculture",
    );

    Map<String, dynamic> responseMap = Map.from(rows[0]);
    String sector = rows[0]['sector'];
    String field = rows[0]['field'];
    String records = rows[0]['records'];

    responseMap["sector"] = jsonDecode(sector);
    responseMap["field"] = jsonDecode(field);
    responseMap["records"] = jsonDecode(records);

    print("field ${responseMap["field"].runtimeType}");


    print("field JSON  ${responseMap["field"][0]}  ");

    return responseMap;
  }

  void delete() {
    database!.execute("DELETE FROM agriculture");
  }
}
