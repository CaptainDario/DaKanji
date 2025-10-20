import 'package:dakanji_db_core/database/dakanji_db.dart';


Future deleteyomitanDictionary(DaKanjiDB db, int indexId) async {

  await deleteIndexEntry(db, indexId);
  await deleteKanjiBankV3(db, indexId);
  await deleteKanjiMetaBankV3(db, indexId);
  await deleteTagBankV3(db, indexId);
  await deleteTermBankV3(db, indexId);
  await deleteTermMetaBankV3(db, indexId);

}

Future deleteIndexEntry(DaKanjiDB db, int indexId) async {
  
  await (db.delete(db.indexTable)
        ..where((tbl) => tbl.id.equals(indexId))).go();

}

/// Deletes all KanjiBankV3 entries and their owned stats for the given index
Future deleteKanjiBankV3(DaKanjiDB db, int indexId) async {
  
  await db.transaction(() async {

    // STEP 1: Find all parent kanji entries to be deleted
    final kanjiEntriesQuery = db.select(db.kanjiBankV3Table)
      ..where((tbl) => tbl.indexId.equals(indexId));
    
    final kanjiIdsToDelete = await kanjiEntriesQuery.map((row) => row.id).get();

    if (kanjiIdsToDelete.isEmpty) return;

    // STEP 2: Find all *owned* stats-related IDs
    // A) Find all related KanjiBankV3StatsTable IDs
    final statIdsQuery = db.select(db.kanjiBankV3XKanjiBankV3StatsTable, distinct: true)
      ..where((tbl) => tbl.kanjiId.isIn(kanjiIdsToDelete));
    final statIdsToDelete = await statIdsQuery.map((row) => row.statId).get();

    if (statIdsToDelete.isNotEmpty) {
      // B) Find the Name and Value IDs from the StatsTable
      final statsQuery = db.select(db.kanjiBankV3StatsTable)
        ..where((tbl) => tbl.id.isIn(statIdsToDelete));
      final statsEntries = await statsQuery.get();

      final statNameIdsToDelete = statsEntries.map((row) => row.statNameId).toSet();
      final statValueIdsToDelete = statsEntries.map((row) => row.statValueId).toSet();

      // STEP 3: Delete the owned stats tables
      // A) Delete from KanjiBankV3StatsTable
      await (db.delete(db.kanjiBankV3StatsTable)
            ..where((tbl) => tbl.id.isIn(statIdsToDelete)))
            .go();
      // B) Delete from KanjiBankV3StatNamesTable
      if (statNameIdsToDelete.isNotEmpty) {
        await (db.delete(db.kanjiBankV3StatNamesTable)
              ..where((tbl) => tbl.id.isIn(statNameIdsToDelete)))
              .go();
      }
      // C) Delete from KanjiBankV3StatValuesTable
      if (statValueIdsToDelete.isNotEmpty) {
        await (db.delete(db.kanjiBankV3StatValuesTable)
              ..where((tbl) => tbl.id.isIn(statValueIdsToDelete)))
              .go();
      }
    }

    // STEP 4: Delete the parent KanjiBankV3Table entries
    // This will trigger `ON DELETE CASCADE` for all 5 link tables,
    await (db.delete(db.kanjiBankV3Table)
          ..where((tbl) => tbl.id.isIn(kanjiIdsToDelete)))
          .go();

  });
}

Future deleteKanjiMetaBankV3(DaKanjiDB db, int indexId) async {
  
  await (db.delete(db.kanjiMetaBankV3Table)
        ..where((tbl) => tbl.indexId.equals(indexId))).go();

}

Future deleteTagBankV3(DaKanjiDB db, int indexId) async {
  
  await (db.delete(db.tagBankV3Table)
        ..where((tbl) => tbl.indexId.equals(indexId))).go();

}

Future deleteTermBankV3(DaKanjiDB db, int indexId) async {
  
  await db.transaction(() async {
    // STEP 1: Find all parent term entries to be deleted
    final termEntriesQuery = db.select(db.termBankV3Table)
      ..where((tbl) => tbl.indexId.equals(indexId));
    
    final termEntries = await termEntriesQuery.get();
    
    if (termEntries.isEmpty) {
      return; // Nothing to do
    }

    final termIdsToDelete = termEntries.map((row) => row.id).toList();

    // STEP 2: Find all *owned* child resources that must be manually deleted
    // A) Definition JSON IDs (from the parent table)
    final defJsonIdsToDelete = termEntries
        .map((row) => row.definitionJsonId)
        .toSet(); // Use Set for automatic deduplication

    // B) Definition Tag IDs (from the link table)
    final defTagIdsQuery = db.select(db.termBankV3XDefinitionTagTable, distinct: true)
      ..where((tbl) => tbl.termBankId.isIn(termIdsToDelete));
    final defTagIdsToDelete = await defTagIdsQuery.map((row) => row.definitionTagId).get();

    // C) Rule Identifier IDs (from the link table)
    final ruleIdsQuery = db.select(db.termBankV3XRuleIdentifierTable, distinct: true)
      ..where((tbl) => tbl.termBankId.isIn(termIdsToDelete));
    final ruleIdsToDelete = await ruleIdsQuery.map((row) => row.ruleIdentifierId).get();

    // STEP 3: Delete the owned child resources (must be done FIRST)
    // A) Delete Definition JSON
    if (defJsonIdsToDelete.isNotEmpty) {
      await (db.delete(db.termBankV3DefinitionJsonTable)
            ..where((tbl) => tbl.id.isIn(defJsonIdsToDelete)))
            .go();
    }
    // B) Delete Definition Tags
    if (defTagIdsToDelete.isNotEmpty) {
      await (db.delete(db.termBankV3DefinitionTagsTable)
            ..where((tbl) => tbl.id.isIn(defTagIdsToDelete)))
            .go();
    }
    // C) Delete Rule Identifiers
    if (ruleIdsToDelete.isNotEmpty) {
      await (db.delete(db.termBankV3RuleIdentifierTable)
            ..where((tbl) => tbl.id.isIn(ruleIdsToDelete)))
            .go();
    }

    // STEP 4: Delete the parent TermBankV3Table entries
    // This will trigger `ON DELETE CASCADE` for all 4 link tables:
    await (db.delete(db.termBankV3Table)
          ..where((tbl) => tbl.indexId.equals(indexId)))
          .go();

  });
}

Future deleteTermMetaBankV3(DaKanjiDB db, int indexId) async {
  
  await db.transaction(() async {
    // STEP 1: Find all parent term meta entries to be deleted
    final metaEntriesQuery = db.select(db.termMetaBankV3Table)
      ..where((tbl) => tbl.indexId.equals(indexId));
    
    final termMetaIdsToDelete = await metaEntriesQuery.map((row) => row.id).get();
    
    if (termMetaIdsToDelete.isEmpty) return; // Nothing to do


    // STEP 2: Find all *owned* child resources
    // A) Find all related Pitch IDs
    final pitchIdsQuery = db.select(db.termMetaBankV3XPitchTable, distinct: true)
      ..where((tbl) => tbl.termMetaId.isIn(termMetaIdsToDelete));
    final pitchIdsToDelete = await pitchIdsQuery.map((row) => row.pitchId).get();

    // B) Find all related Ipa IDs
    final ipaIdsQuery = db.select(db.termMetaBankV3XIpaTable, distinct: true)
      ..where((tbl) => tbl.termMetaId.isIn(termMetaIdsToDelete));
    final ipaIdsToDelete = await ipaIdsQuery.map((row) => row.ipaId).get();


    // STEP 3: Delete the owned child resources (must be done FIRST)
    // A) Delete Pitch entries
    // This will trigger the cascade to TermMetaBankV3_X_PitchTagTable
    if (pitchIdsToDelete.isNotEmpty) {
      await (db.delete(db.termMetaBankV3PitchTable)
            ..where((tbl) => tbl.id.isIn(pitchIdsToDelete)))
            .go();
    }
    // B) Delete Ipa entries
    // This will trigger the cascade to TermMetaBankV3_X_IpaTagTable
    if (ipaIdsToDelete.isNotEmpty) {
      await (db.delete(db.termMetaBankV3IpaTable)
            ..where((tbl) => tbl.id.isIn(ipaIdsToDelete)))
            .go();
    }

    // STEP 4: Delete the parent TermMetaBankV3Table entries
    // This will trigger the cascade for the main link tables:
    await (db.delete(db.termMetaBankV3Table)
          ..where((tbl) => tbl.id.isIn(termMetaIdsToDelete)))
          .go();

  });
}