import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/audio_source_list/audio_source_list_entry.dart';
import 'package:da_db/database/index/index_table_entry.dart';

IndexEntry index = IndexEntry(
  id: 1,
  isDefaultDictionary: true,
  enabled: true,
  dictionaryType: DictionaryTypes.yomitan,
  currentSortingOrder: 1,
  currentFrequencyDictionary: false,
  title: "Test Example Dictionary",
  format: 3,
  revision: "2024-01-01",
  sequenced: true,
  author: "Test Author",
  description: "A dictionary for testing the example parser."
);

List<AudioSourceListEntry> audioListTestCases = [
  AudioSourceListEntry(
    name: "JapanesePod101",
    uri: "https://assets.languagepod101.com/dictionary/japanese/audiomp3.php?kanji={{KANJI}}&kana={{KANA}}",
    indexEntry: index
  ),
  AudioSourceListEntry(
    name: "JapanesePod102",
    uri: "https://assets.languagepod102.com/dictionary/japanese/audiomp3.php?kanji={{KANJI}}&kana={{KANA}}",
    indexEntry: index
  ),
];