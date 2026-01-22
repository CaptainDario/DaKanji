import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:dakanji_db_core/util/check_dict_updates.dart';
import 'package:test/test.dart';



void main() async {

  IndexEntry entry = IndexEntry(
    id: 0,
    isDefaultDictionary: false,
    enabled: false,
    dictionaryType: DictionaryTypes.yomitan,
    currentSortingOrder: 0,
    currentFrequencyDictionary: false,
    title: "JMDict",
    revision: "JMdict.2024-01-01",
    indexUrl: "https://github.com/yomidevs/jmdict-yomitan/releases/latest/download/JMdict_english.json",
    downloadUrl: "https://github.com/yomidevs/jmdict-yomitan/releases/latest/download/JMdict_english.zip",
    isUpdatable: true,
  );

  bool hasUpdates = await checkDictionaryUpdates(entry);

  print(hasUpdates);

  expect(hasUpdates, true);

}
