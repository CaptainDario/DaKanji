import 'package:dakanji_db_core/database/dictionary_types.dart';
import 'package:dakanji_db_core/database/index/index_table_entry.dart';



IndexEntry testDictionaryIndexEntry = IndexEntry(
  id: 1,
  dictionaryType: DictionaryTypes.yomitan,
  currentSortingOrder: 1,
  currentFrequencyDictionary: false,

  title: "Test Dictionary",
  format: 3,
  revision: "test",
  sequenced: true
);