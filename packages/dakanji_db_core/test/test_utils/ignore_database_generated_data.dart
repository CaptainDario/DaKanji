import 'package:dakanji_db_core/database/kanji/kanji_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/kanji_meta/kanji_meta_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';



KanjiBankV3Entry kanjiBankEntryIgnoreDatabaseGeneratedData(KanjiBankV3Entry entry) {
  return entry.copyWith(
    id: 0,
    indexEntry: entry.indexEntry.copyWith(id: 0, currentSortingOrder: 0),
    tags: entry.tags.map((t) => t.copyWith(
      id: 0,
      indexEntry: t.indexEntry.copyWith(id: 0, currentSortingOrder: 0)
    )).toList(),
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