

import 'package:dakanji_db_core/database/kanji/kanji_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/kanji_meta/kanji_meta_bank_v3_entry.dart';

class KanjiDictionarySearchResultTestCaseExpectation {

  KanjiBankV3Entry kanjiBankEntry;
  List<KanjiMetaBankV3Entry> kanjiMetaBankEntries;

  KanjiDictionarySearchResultTestCaseExpectation({
    required this.kanjiBankEntry,
    required this.kanjiMetaBankEntries,
  });

}