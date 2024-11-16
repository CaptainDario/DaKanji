import 'dart:convert';
import 'dart:io';

import 'package:dakanji_db/database/dakanji_db.dart';



/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseKanjiBankV3(File kanjiBankV3JsonPath, DaKanjiDB db) async {

  // read and decode the json
  String jsonString = kanjiBankV3JsonPath.readAsStringSync();
  List jsonList = jsonDecode(jsonString);

  //
  print(jsonList.first);

  // Perform the insertion inside a transaction
  await db.transaction(() async {
      
      for (var i = 0; i < jsonList.length; i++) {
        
        int kanjiId = await db.into(db.kanjiBankV3Table).insert(
          KanjiBankV3TableCompanion.insert(
            kanji: jsonList[0][0]
          )
        );

        // onyomi
        for (var i = 1; i < 4; i++) {
          if(jsonList[0][1] != ""){
            List<String> onyomis = jsonList[0][1].toString().split(" ");
            for (String onyomi in onyomis) {
              await db.into(db.kanjiBankV3OnyomiTable).insert(
                KanjiBankV3OnyomiTableCompanion.insert(
                  onyomi: onyomi,
                  kanjiBankV3ID: kanjiId
                )
              );
            }
          }
        }
        
        // kunyomi
        if(jsonList[0][2] != ""){
          List<String> kunyomis = jsonList[0][2].toString().split(" ");
          for (String kunyomi in kunyomis) {
            await db.into(db.kanjiBankV3KunyomiTable).insert(
              KanjiBankV3KunyomiTableCompanion.insert(
                kunyomi: kunyomi,
                kanjiBankV3ID: kanjiId
              )
            );
          }
        }

        // tags
        if(jsonList[0][3] != ""){
          List<String> tags = jsonList[0][3].toString().split(" ");
          for (String tag in tags) {
            await db.into(db.kanjiBankV3TagTable).insert(
              KanjiBankV3TagTableCompanion.insert(
                tag: tag,
                kanjiBankV3ID: kanjiId
              )
            );
          }
        }

        // meanings
        if(jsonList[0][4] != ""){
          List<String> meanings = List<String>.from(jsonList[0][4]);
          for (String meaning in meanings) {
            await db.into(db.kanjiBankV3MeaningsTable).insert(
              KanjiBankV3MeaningsTableCompanion.insert(
                meaning: meaning.toString(),
                kanjiBankV3ID: kanjiId
              )
            );
          }
        }

        // stats
        if(jsonList[0][5] != ""){
          Map<String, String> stats = Map<String, String>.from(jsonList[0][5]);
          for (MapEntry<String, String> meaning in stats.entries) {
            await db.into(db.kanjiBankV3StatsTable).insert(
              KanjiBankV3StatsTableCompanion.insert(
                statName: meaning.key.toString(),
                statValue: meaning.value.toString(),
                kanjiBankV3ID: kanjiId
              )
            );
          }
        }

      }    

  });

}