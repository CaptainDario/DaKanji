import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_db/database/index/yomitan_index.dart';
import 'package:language_processing/language_processing.dart';

final dummyIndexBank1Jpn = IndexEntry(
  id: 0,
  isDefaultDictionary: true,
  enabled: true,
  dictionaryType: DictionaryTypes.examples, 
  currentSortingOrder: 0,
  currentFrequencyDictionary: false,

  yomitanData: YomitanIndex(
    title: "Test Example Dictionary", 
    revision: "2024-01-01",
    format: 3,
    sequenced: true,
    author: "Test Author", 
    description: "A dictionary for testing the example parser.",
    sourceLanguage: Iso639_3.jpn
  )
);
final dummyIndexBank2Jpn = IndexEntry(
  id: 0,
  isDefaultDictionary: true,
  enabled: true,
  dictionaryType: DictionaryTypes.examples, 
  currentSortingOrder: 0,
  currentFrequencyDictionary: false,
  yomitanData: YomitanIndex(
    title: "Source Japanese",
    revision: "1",
    format: 3,
    sourceLanguage: Iso639_3.jpn,
    sequenced: true,
    author: null,
    description: null,
  )
);
final dummyIndexBank3Eng = dummyIndexBank2Jpn.copyWith(
  yomitanData: dummyIndexBank2Jpn.yomitanData.copyWith(
    title: "Target English 1",
    sourceLanguage: Iso639_3.eng
  )
);
final dummyIndexBank4Eng = dummyIndexBank3Eng.copyWith(
  yomitanData: dummyIndexBank3Eng.yomitanData.copyWith(
    title: "Target English 2",
  )
);

final dummyIndexTexts1Jpn = IndexEntry(
  id: 0,
  isDefaultDictionary: true,
  enabled: true,
  dictionaryType: DictionaryTypes.examples, 
  currentSortingOrder: 0,
  currentFrequencyDictionary: false,

  yomitanData: YomitanIndex(
    title: "Test Example Dictionary", 
    revision: "2024-01-01",
    format: 3,
    sequenced: true,
    description: "A dictionary for testing the example parser.",
  )
);