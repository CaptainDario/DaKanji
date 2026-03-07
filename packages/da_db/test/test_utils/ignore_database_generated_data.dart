import 'package:da_db/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart';
import 'package:da_db/database/example/example_entry.dart';
import 'package:da_db/database/kanji/kanji_bank_v3_entry.dart';
import 'package:da_db/database/kanji_meta/kanji_meta_bank_v3_entry.dart';
import 'package:da_db/database/term/term_bank_v3_entry.dart';
import 'package:da_db/database/term_meta/term_meta_bank_entry.dart';



KanjiBankV3Entry kanjiBankEntryIgnoreDatabaseGeneratedData(KanjiBankV3Entry entry) {
  return entry.copyWith(
    id: 0,
    indexEntry: entry.indexEntry.copyWith(id: 0, currentSortingOrder: 0),
    tags: entry.tags.map((t) => t.copyWith(
      id: 0,
      indexEntry: t.indexEntry.copyWith(id: 0, currentSortingOrder: 0)
    )).toList(),
    stats: entry.stats.map((s) => s.copyWith(
      tag: s.tag.copyWith(
        id: 0,
        indexEntry: s.tag.indexEntry.copyWith(id: 0, currentSortingOrder: 0)
      )
    )).toList()
  );
}


KanjiMetaBankV3Entry kanjiMetaBankEntryIgnoreDatabaseGeneratedData(KanjiMetaBankV3Entry entry) {
  return entry.copyWith(
    id: 0,
    indexEntry: entry.indexEntry.copyWith(id: 0, currentSortingOrder: 0),
  );
}


TermBankV3Entry termBankV3EntryIgnoreDatabaseGeneratedData(TermBankV3Entry entry) {
  return entry.copyWith(
      id: 0, // ignore ids in comparison;
      indexEntry: entry.indexEntry.copyWith(id: 0, currentSortingOrder: 0),
      tags: entry.tags.map((tag) => tag.copyWith(
        indexEntry: entry.indexEntry.copyWith(
          id: 0,
          currentSortingOrder: 0
        ),
        id: 0
      )).toList(),
      definitionTags: entry.definitionTags.map((tag) =>
        tag.copyWith(
          id: 0,
          indexEntry: entry.indexEntry.copyWith(
            id: 0,
            currentSortingOrder: 0
          )
        )
      ).toList()  
    );
}

TermMetaBankV3Entry termMetaBankV3EntryIgnoreDatabaseGeneratedData(TermMetaBankV3Entry entry) {
  final standardIndex = entry.indexEntry.copyWith(id: 0, currentSortingOrder: 0);
  return entry.copyWith(
      id: 0, // ignore the id in comparison
      indexEntry: standardIndex,
      ipas: entry.ipas.map((ipa) => ipa.copyWith(
        tags: ipa.tags.map((tag) => tag.copyWith(
          id: 0, // ignore tag ids
          indexEntry: standardIndex
        )).toList() 
      )).toList(),
      pitchs: entry.pitchs.map((pitch) => pitch.copyWith(
        tags: pitch.tags.map((tag) => tag.copyWith(
          id: 0, // ignore tag ids
          indexEntry: standardIndex
        )).toList() 
      )).toList()
    );
}

KanjiDictionarySearchResult kanjiDictionarySearchResultIgnoreDatabaseGeneratedData(KanjiDictionarySearchResult result) {
  return result.copyWith(
    kanjiBankEntry: kanjiBankEntryIgnoreDatabaseGeneratedData(result.kanjiBankEntry),
    kanjiMetaBankEntries: result.kanjiMetaBankEntries.map(
      (e) => kanjiMetaBankEntryIgnoreDatabaseGeneratedData(e)
    ).toList()
  );
}

ExampleEntry exampleEntryIgnoreDatabaseGeneratedData(ExampleEntry entry) {
  final standardIndex = entry.indexEntry.copyWith(
    id: 0, 
    currentSortingOrder: 0,
  );

  return entry.copyWith(
    id: 0, // Ignore DB auto-increment ID
    indexEntry: standardIndex,
    // Normalize root tags
    tags: entry.tags.map((t) => t.copyWith(
      id: 0, 
      indexEntry: standardIndex,
    )).toList(),
    // Normalize audio tags
    audios: entry.audios.map((audio) => audio.copyWith(
      id: 0,
      tags: audio.tags.map((t) => t.copyWith(
        id: 0,
        indexEntry: standardIndex,
      )).toList(),
      stats: audio.stats.map((s) => s.copyWith(
        id: 0,
      )).toList()
    )).toList(),
    stats: entry.stats.map((s) => s.copyWith(
      id: 0,
    )).toList(),
  );
}