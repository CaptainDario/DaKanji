// Dart imports:
import 'dart:convert';
import 'dart:isolate';

// Package imports:
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';

// Project imports:
import '/database/dakanji_db.dart';

/// map to lookup the code that is stored in the krad/radk file to an actual
/// radical
Map<String, String> codeLookup = {
  "js01" : "⺅", // 化
  "js02" : "𠆢", // 个
  "js07" : "丷", // 并
  "3331" : "⺉", // 刈
  "js10" : "𠂉", // 乞
  "6134" : "⻌", // 込
  "js04" : "⺌", // 尚
  "3D38" : "⺖", // 忙
  "3F37" : "扌", // 扎
  "4653" : "⺡", // 汁
  "4A6D" : "⺨", // 犯
  "js03" : "⺾", // 艾
  "js05" : "⺹", // 老
  "4944" : "⺣", // 杰
  "504B" : "⺭", // 礼
  "4D46" : "⽧", // 疔
  "5072" : "⽱", // 禹
  "5C33" : "⻂", // 初
  "5474" : "⺲", // 買
  "3557" : "啇", // 滴
  "kozatoR" : "⻏", // 邦
  "kozatoL" : "⻖", // 阡
};

/// map to lookup the character that is used to indicate a radica in the krad/
/// radk file to an actual radical
Map<String, String> kanjiCodeLookup = {
  "化" : "⺅",
  "个" : "𠆢",
  "并" : "丷",
  "刈" : "⺉",
  "乞" : "𠂉", 
  "込" : "⻌", 
  "尚" : "⺌", 
  "忙" : "⺖", 
  "扎" : "扌", 
  "汁" : "⺡", 
  "犯" : "⺨", 
  "艾" : "⺾", 
  "老" : "⺹", 
  "杰" : "⺣", 
  "礼" : "⺭", 
  "疔" : "⽧", 
  "禹" : "⽱", 
  "初" : "⻂", 
  "買" : "⺲", 
  "滴" : "啇", 
  "邦" : "⻏", 
  "阡" : "⻖", 
};


/// Converts the radk and krad file at the given paths and adds them to the
/// given DaKanji db
Future addRadicalsToDB(String radkPath, String kradPath, DaKanjiDB db) async {

  final connection = await db.attachedDatabase.serializableConnection();

  // spawn isolate
  await Isolate.run(() async {
    await _addRadicalsToDB(radkPath, kradPath, connection);
  });
}


/// Actual implementation of the [_addRadicalsToDB] that runs in an isolate
Future _addRadicalsToDB(String radkPath, String kradPath, DriftIsolate dbConnection) async {

  // reconnect to the database
  final db = DaKanjiDB(executor: await dbConnection.connect());

  // load radical files
  Map radkMap = jsonDecode(dakanjiDBDataSourceIterator(
    archivePath: radkPath).first.fileContent)["radicals"];
  Map kradMap = jsonDecode(dakanjiDBDataSourceIterator(
    archivePath: kradPath).first.fileContent)["kanji"];

  // get all entries that are currently in the kanji db
  final kanjis = { for (var e in await db.kanjiDao.getAllKanjis()) e.kanji : e.id };
  int maxKanjiId = await db.kanjiDao.maxKanjiId();

  // Lists to store the companions to later batch insert them into SQLite
  List<RadicalsTableCompanion> radComps = [
    RadicalsTableCompanion(id: Value(1), radical: Value("龠"), strokeCount: Value(17))
  ];
  List<KanjiTableCompanion> kanjiComps = [];
  List<Radical_X_KanjiRelationsTableCompanion> radKanRelComps = [];

  // ids of radicals in the sqlite db
  Map<String, int> radicalIds = {
    "龠" : 1
  };

  // add all radicals to sqlite and get their ID
  int radId = radComps.length;
  for (var radkItem in radkMap.entries) {
    String radical = radkItem.value["code"] == null
      ? radkItem.key
      : codeLookup[radkItem.value["code"]];
      
    radComps.add(
      RadicalsTableCompanion(
        id: Value(++radId),
        radical: Value(radical),
        strokeCount: Value(radkItem.value["strokeCount"]))
    );
    radicalIds[radical] = radId;
  }

  // add all kanji and the links between kanji <--> radical
  for (var kradItem in kradMap.entries) {
    
    if(kanjis[kradItem.key] == null){

      kanjis[kradItem.key] = ++maxKanjiId;
      // add the kanji into the db
      kanjiComps.add(
        KanjiTableCompanion(
          id: Value(maxKanjiId),
          kanji: Value(kradItem.key!))
      );
    
    }

    // create the realtionships between kanji and radical
    for (var radical in kradItem.value) {

      if(["", " "].contains(radical)) continue;

      radKanRelComps.add(Radical_X_KanjiRelationsTableCompanion(
        kanjiId: Value(maxKanjiId),
        radicalId: Value(
          (kanjiCodeLookup[radical] != null
            ? radicalIds[kanjiCodeLookup[radical]]  
            : radicalIds[radical])!
        )
      ));
    }

    //
  }

  await db.batch((batch) {
    batch.insertAll(db.radicalXKanjiRelationsTable, radKanRelComps);
    batch.insertAll(db.radicalsTable, radComps);
    batch.insertAll(db.kanjiTable, kanjiComps);
  });

}
