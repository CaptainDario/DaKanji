import 'package:dakanji_db_core/database/dictionary_types.dart';
import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';



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



TagBankV3Entry e1Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "E1",
  category: "default",
  sortingOrder: 0, 
  notes: "example tag 1",
  score: 0
);

TagBankV3Entry e2Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "E2",
  category: "default",
  sortingOrder: 0, 
  notes: "example tag 2",
  score: 0
);

TagBankV3Entry pTag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "P",
  category: "popular",
  sortingOrder: 0,
  notes: "popular term",
  score: 0
);

TagBankV3Entry nTag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "n",
  category: "partOfSpeech",
  sortingOrder: 0, 
  notes: "noun",
  score: 0
);

TagBankV3Entry vtTag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "vt",
  category: "partOfSpeech",
  sortingOrder: 0, 
  notes: "transitive verb",
  score: 0
);

TagBankV3Entry abbrTag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "abbr",
  category: "default",
  sortingOrder: 0, 
  notes: "abbreviation",
  score: 0
);


// --- made up tags for testing ---
TagBankV3Entry naAdjTag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "adj-na",
  category: "",
  sortingOrder: 0, 
  notes: "",
  score: 0
);

TagBankV3Entry v5Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "v5",
  category: "",
  sortingOrder: 0, 
  notes: "",
  score: 0
);

TagBankV3Entry iAdjTag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "adj-i",
  category: "",
  sortingOrder: 0, 
  notes: "",
  score: 0
);

TagBankV3Entry vtag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "v",
  category: "",
  sortingOrder: 0, 
  notes: "",
  score: 0
);