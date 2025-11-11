
import 'package:dakanji_db_core/database/kanji_meta/kanji_meta_bank_v3_entry.dart';

import '../dictionary_test_variables.dart';

final int indexId = 1;
final kanjiMetaBankTetsCases = ["打"];
/// kanjiMetaBankV3 test case expected values
final kanjiMetaBankTetsCaseExpectations = [
  KanjiMetaBankV3Entry(
    id: 0,
    indexEntry: testDictionaryIndexEntry,
    kanji: "打",
    type: "freq",
    freqValue: 1,
    freqDisplayValue: null
  ),
  KanjiMetaBankV3Entry(
    id: 0,
    indexEntry: testDictionaryIndexEntry,
    kanji: "打",
    type: "freq",
    freqValue: null,
    freqDisplayValue: "three"
  ),
  KanjiMetaBankV3Entry(
    id: 0,
    indexEntry: testDictionaryIndexEntry,
    kanji: "打",
    type: "freq",
    freqValue: 5, 
    freqDisplayValue: null
  ),
];