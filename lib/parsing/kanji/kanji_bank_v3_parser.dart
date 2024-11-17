import 'dart:convert';
import 'dart:io';

import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:drift/drift.dart';



/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseKanjiBankV3(File kanjiBankV3JsonPath, DaKanjiDB db) async {

  // read and decode the json
  String jsonString = kanjiBankV3JsonPath.readAsStringSync();
  List jsonList = jsonDecode(jsonString);
  print(jsonList.length);

  // lists to store the companion objects
  List<KanjiBankV3TableCompanion> kanjis = [];
  int kanjiId = await db.kanjiBankV3Dao.maxKanjiId();
  print("Max kanji id $kanjiId");
  List<KanjiBankV3OnyomisTableCompanion>  onyomis  = [];
  int onyomiId = await db.kanjiBankV3Dao.maxOnyomiId();
  List<KanjiBankV3OnyomiKanjiRelationsTableCompanion> onyomiRels = [];
  //List<KanjiBankV3KunyomisTableCompanion> kunyomis = [];
  //List<KanjiBankV3KunyomisTableCompanion> tags     = [];
  //List<KanjiBankV3MeaningsTableCompanion> meanings = [];
  //List<KanjiBankV3StatsTableCompanion>    stats    = [];

  // populate the companion lists
  for (var i = 0; i < jsonList.length; i++) {
    
    int? kanjiInsertId = await db.kanjiBankV3Dao.getKanjiId(jsonList[i][0]) ?? ++kanjiId;
    kanjis.add(KanjiBankV3TableCompanion(
      id: Value(kanjiInsertId),
      kanji: Value(jsonList[i][0])
    ));

    if(jsonList[i][1] != ""){
      for (var onyomi in jsonList[i][1].toString().split(" ")) {
        
        int? onyomiInsertId = await db.kanjiBankV3Dao.getKanjiId(jsonList[i][0]) ?? ++onyomiId;
        onyomis.add(KanjiBankV3OnyomisTableCompanion(
          id: Value(onyomiInsertId),
          kanjiBankV3ID: Value(kanjiInsertId),
          onyomi: Value(onyomi)
        ));
        onyomiRels.add(KanjiBankV3OnyomiKanjiRelationsTableCompanion(
          kanjiId: Value(kanjiInsertId),
          onyomiId: Value(onyomiInsertId)
        ));
      
      }
    }
  }

  // Perform the insertion inside a transaction
  await db.batch((batch) {
    
    batch.insertAll(db.kanjiBankV3Table, kanjis,
      mode: InsertMode.insertOrIgnore);

    batch.insertAll(db.kanjiBankV3OnyomisTable, onyomis,
      mode: InsertMode.insertOrIgnore);
    batch.insertAll(db.kanjiBankV3OnyomiKanjiRelationsTable, onyomiRels,
      mode: InsertMode.insertOrIgnore);

    //batch.insertAll(db.kanjiBankV3KunyomisTable, onyomis);

    //batch.insertAll(db.kanjiBankV3TagsTable, tags);

    //batch.insertAll(db.kanjiBankV3MeaningsTable, meanings);
    
    //batch.insertAll(db.kanjiBankV3StatsTable, stats);

  });

}