import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';



IndexEntry testDictionaryIndexEntry = IndexEntry(
  id: 0,
  dictionaryType: DictionaryTypes.yomitan,
  currentSortingOrder: 0,
  currentFrequencyDictionary: false,

  title: "Test Dictionary",
  format: 3,
  revision: "test",
  sequenced: true
);
IndexEntry audioFormat1ExampleDictionaryIndexEntry = IndexEntry(
  id: 1,
  dictionaryType: DictionaryTypes.audio,
  currentSortingOrder: 0,
  currentFrequencyDictionary: false,

  title: "Example Audio Entries Format Test [2025-11-02]",
  format: 3,
  revision: "example_audio_entries_format_test.2025-11-02",
  sequenced: false
);
IndexEntry audioFormat2ExampleDictionaryIndexEntry = IndexEntry(
  id: 1,
  dictionaryType: DictionaryTypes.audio,
  currentSortingOrder: 0,
  currentFrequencyDictionary: false,

  title: "Example Audio Index Format Test [2025-11-02]",
  format: 3,
  revision: "example_audio_index_format_test.2025-11-02",
  sequenced: false
);
IndexEntry audioFormat3ExampleDictionaryIndexEntry = IndexEntry(
  id: 1,
  dictionaryType: DictionaryTypes.audio,
  currentSortingOrder: 0,
  currentFrequencyDictionary: false,

  title: "Example Audio File Name Format Test [2025-11-02]",
  format: 3,
  revision: "example_audio_file_name_format_test.2025-11-02",
  sequenced: false
);

// --- data from tag_bank_1.json ---
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

// --- data from tag_bank_2.json ---
TagBankV3Entry k1Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "K1",
  category: "default",
  sortingOrder: 0, 
  notes: "example kanji tag 1",
  score: 0
);

TagBankV3Entry k2Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "K2",
  category: "default",
  sortingOrder: 0, 
  notes: "example kanji tag 2",
  score: 0
);

TagBankV3Entry kstat1Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "kstat1",
  category: "class",
  sortingOrder: 0, 
  notes: "kanji stat 1",
  score: 0
);

TagBankV3Entry kstat2Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "kstat2",
  category: "code",
  sortingOrder: 0, 
  notes: "kanji stat 2",
  score: 0
);

TagBankV3Entry kstat3Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "kstat3",
  category: "index",
  sortingOrder: 0, 
  notes: "kanji stat 3",
  score: 0
);

TagBankV3Entry kstat4Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "kstat4",
  category: "misc",
  sortingOrder: 0, 
  notes: "kanji stat 4",
  score: 0
);

TagBankV3Entry kstat5Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "kstat5",
  category: "misc",
  sortingOrder: 0, 
  notes: "kanji stat 5",
  score: 0
);

// --- data from tag_bank_3.json ---
TagBankV3Entry p1Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "P1",
  category: "default",
  sortingOrder: 0, 
  notes: "example pitch tag 1",
  score: 0
);
TagBankV3Entry p2Tag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "P2",
  category: "default",
  sortingOrder: 0, 
  notes: "example pitch tag 2",
  score: 0
);


// --- tags created DURING parsing of dictionary ---
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

TagBankV3Entry tokyoTag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "東京",
  category: "",
  sortingOrder: 0, 
  notes: "",
  score: 0
);

TagBankV3Entry kyotoTag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "京東",
  category: "",
  sortingOrder: 0, 
  notes: "",
  score: 0
);

TagBankV3Entry testTag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "test",
  category: "",
  sortingOrder: 0, 
  notes: "",
  score: 0
);

TagBankV3Entry asdTag = TagBankV3Entry(
  id: 0,
  indexEntry: testDictionaryIndexEntry,
  name: "asd",
  category: "",
  sortingOrder: 0, 
  notes: "",
  score: 0
);