import 'dart:convert';

import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_db/database/index/yomitan_index.dart';
import 'package:da_db/util/check_dict_updates.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';



void main() async {

  IndexEntry entry = IndexEntry(
    id: 0,
    isDefaultDictionary: false,
    enabled: false,
    dictionaryType: DictionaryTypes.yomitan,
    currentSortingOrder: 0,
    currentFrequencyDictionary: false,
    yomitanData: YomitanIndex(
      title: "JMDict",
      revision: "JMdict.2024-01-01",
      indexUrl: "https://github.com/yomidevs/jmdict-yomitan/releases/latest/download/JMdict_english.json",
      downloadUrl: "https://github.com/yomidevs/jmdict-yomitan/releases/latest/download/JMdict_english.zip",
      isUpdatable: true,
    )
  );

  test("Test old dict shows update available", () async {

    bool hasUpdates = await checkIfDictionaryHasUpdates(entry);

    // check that old dict shows updates available
    expect(hasUpdates, true);

  });

  test("Test newest dict shows no updates available", () async {

    // set revision to latest known
    Dio d = Dio();
    final latest = await d.get(entry.indexUrl!);
    final latestJson = jsonDecode(latest.data);
    entry = entry.copyWith(yomitanData: entry.yomitanData.copyWith(
      revision: latestJson['revision']
    ));

    bool hasUpdates = await checkIfDictionaryHasUpdates(entry);

    // check that newest dict shows no updates available
    expect(hasUpdates, false);

  });
}
