import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/database/kanji/kanji_bank_entry.dart';
import 'package:dakanji_db/database/kanji/kanji_bank_entry_stat.dart';
import 'package:dakanji_db/database/kanji_meta/kanji_meta_bank_entry.dart';
import 'package:dakanji_db/database/tag/tag_bank_entry.dart';
import 'package:dakanji_db/parsing/dictionary_parser.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../bin/paths.dart';



/// Test cases for the kanji bank
final kanjiBankTetsCases = [
  "打"
];
/// kanji bank test case expected values
final kanjiBankTetsCaseExpectations = [
  KanjiBankEntry(
    kanji: "打",
    onyomis: ["ダ", "ダアス"],
    kunyomis: ["う.つ", "う.ち-", "ぶ.つ"],
    tags: [
      TagBankEntry(
        name: "K1",
        categories: "default",
        sortingOrder: 0,
        notes: "example kanji tag 1",
        score: 0),
      TagBankEntry(
        name: "K2",
        categories: "default",
        sortingOrder: 0, 
        notes: "example kanji tag 2",
        score: 0)
    ],
    meanings: [
      "utsu meaning 1",
      "utsu meaning 2",
      "utsu meaning 3",
      "utsu meaning 4",
      "utsu meaning 5"
    ],
    stats: [
      KanjiBankEntryStat(
        name: "kstat1",
        value: "kanji stat 1 value"
      ), 
      KanjiBankEntryStat(
        name: "kstat2",
        value: "kanji stat 2 value"
      ),
      KanjiBankEntryStat(
        name: "kstat3",
        value: "kanji stat 3 value"
      ),
      KanjiBankEntryStat(
        name: "kstat4",
        value: "kanji stat 4 value"
      ),
      KanjiBankEntryStat(
        name: "kstat5",
        value: "kanji stat 5 value"
      )
    ]
  )
];

/// Test cases for the kanji meta bank
final kanjiMetaBankTetsCases = ["打"];
/// kanjiMetaBankV3 test case expected values
final kanjiMetaBankTetsCaseExpectations = [
  KanjiMetaBankV3Entry(kanji: "打", type: "freq", freqValue: 1, freqDisplayValue: null),
  KanjiMetaBankV3Entry(kanji: "打", type: "freq", freqValue: null, freqDisplayValue: "three"),
  KanjiMetaBankV3Entry(kanji: "打", type: "freq", freqValue: 5, freqDisplayValue: null),
];


void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  await db.deleteDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(samplesPath), db);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing samples', () async {
    await testKanjiBankV3(db);
    await testKanjiMetaBankV3(db);
  });
}

Future testKanjiBankV3(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (var testCase in kanjiBankTetsCases) {
    Stopwatch s = Stopwatch()..start();
    List result = (await db.kanjiBankV3Dao.getKanjiBankEntriesFromKanji([testCase]))!;
    print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
    print(result);

    for (var entry in result) {
      expect(kanjiBankTetsCaseExpectations.contains(entry), true);
    }
  }
}

Future testKanjiMetaBankV3(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (var testCase in kanjiMetaBankTetsCases) {
    Stopwatch s = Stopwatch()..start();
    List result = (await db.kanjiMetaBankV3Dao.getKanjiMetaBankEntriesFromKanji([testCase]))!;
    print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
    print(result);

    for (var entry in result) {
      expect(kanjiMetaBankTetsCaseExpectations.contains(entry), true);
    }
  }
}
