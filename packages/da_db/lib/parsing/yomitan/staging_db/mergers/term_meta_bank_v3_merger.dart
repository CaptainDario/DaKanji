import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/yomitan_index.dart';
import 'package:da_db/parsing/staging_db/mergers/staging_merger.dart';
import 'package:language_processing/language_processing.dart';

class TermMetaBankV3Merger implements StagingMerger {
  
  @override
  Future<void> merge({
    required DaDb targetDb,
    required String workerAlias,
    required YomitanIndex index,
    required int indexId,
  }) async {

    final bool isSourceSpaceLang = usesSpaceSeparation(index.sourceLanguage);

    final String ftsTermsTable = isSourceSpaceLang ? "fts_terms_unicode" : "fts_terms";
    final String ftsReadingsTable = isSourceSpaceLang ? "fts_readings_unicode" : "fts_readings";
    
    // Pre-fetch Max IDs
    final maxMetaId = await targetDb.termMetaBankV3Dao.maxTermMetaBankV3Id();
    final maxPitchId = await targetDb.termMetaBankV3Dao.maxTermMetaBankV3PitchId();
    final maxIpaId = await targetDb.termMetaBankV3Dao.maxTermMetaBankV3IpaId();
    final maxTermId = await targetDb.termDao.maxTermId();
    final maxReadingId = await targetDb.readingDao.maxReadingId();

    // Table references
    final tTerm = targetDb.termTable;
    final tReading = targetDb.readingTable;
    final tType = targetDb.termMetaBankV3TypeTable;
    final tTag = targetDb.tagBankV3Table;
    
    final tMeta = targetDb.termMetaBankV3Table;
    final tPitch = targetDb.termMetaBankV3PitchTable;
    final tIpa = targetDb.termMetaBankV3IpaTable;

    final tjPitch = targetDb.termMetaBankV3XPitchTable;
    final tjPitchTag = targetDb.termMetaBankV3PitchTableXTagBankV3Table;
    final tjIpa = targetDb.termMetaBankV3XIpaTable;
    final tjIpaTag = targetDb.termMetaBankV3IpaTableXTagBankV3Table;

    try {
      // Terms
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tTerm.actualTableName} (${tTerm.term.name}, ${tTerm.termNormalized.name})
        SELECT DISTINCT term, term_normalized
        FROM $workerAlias.term_meta_staging_table
      ''');
      await targetDb.customStatement('''
        INSERT INTO $ftsTermsTable(rowid, term, term_normalized)
        SELECT id, term, term_normalized FROM ${tTerm.actualTableName} WHERE id > $maxTermId
      ''');

      // Types (Modes)
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tType.actualTableName} (${tType.type.name})
        SELECT DISTINCT mode FROM $workerAlias.term_meta_staging_table
      ''');

      // Readings
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tReading.actualTableName} (${tReading.reading.name}, ${tReading.readingNormalized.name})
        SELECT DISTINCT reading, reading_normalized 
        FROM $workerAlias.term_meta_staging_table
        WHERE reading IS NOT NULL
      ''');
      await targetDb.customStatement('''
        INSERT INTO $ftsReadingsTable(rowid, reading, reading_normalized)
        SELECT id, reading, reading_normalized FROM ${tReading.actualTableName} WHERE id > $maxReadingId
      ''');

      // Tags (from Pitch/IPA staging)
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tTag.actualTableName} (${tTag.indexId.name}, ${tTag.name.name}, ${tTag.category.name}, ${tTag.sortingOrder.name}, ${tTag.notes.name}, ${tTag.score.name})
        SELECT DISTINCT $indexId, tag_name, '', 0, '', 0 
        FROM $workerAlias.term_meta_tag_staging_table s
        WHERE NOT EXISTS (
          SELECT 1 FROM ${tTag.actualTableName} t 
          WHERE t.name = s.tag_name AND t.index_id = $indexId
        )
      ''');

      // 2. Insert Main Term Meta Entries
      await targetDb.customStatement('''
        INSERT INTO ${tMeta.actualTableName} (
          ${tMeta.id.name}, ${tMeta.indexId.name}, ${tMeta.termId.name}, ${tMeta.typeId.name}, 
          ${tMeta.readingId.name}, ${tMeta.freqValue.name}, ${tMeta.freqDisplayValue.name}
        )
        SELECT 
          $maxMetaId + s.local_id,
          $indexId,
          t.${tTerm.id.name},
          typ.${tType.id.name},
          r.${tReading.id.name},
          s.freq_value,
          s.freq_display
        FROM $workerAlias.term_meta_staging_table s
        JOIN ${tTerm.actualTableName} t ON t.${tTerm.term.name} = s.term
        JOIN ${tType.actualTableName} typ ON typ.${tType.type.name} = s.mode
        LEFT JOIN ${tReading.actualTableName} r ON r.${tReading.reading.name} = s.reading
      ''');

      // 3. Insert Pitches
      await targetDb.customStatement('''
        INSERT INTO ${tPitch.actualTableName} (${tPitch.id.name}, ${tPitch.position.name}, ${tPitch.nasal.name}, ${tPitch.devoice.name})
        SELECT $maxPitchId + s.pitch_local_id, s.position, s.nasal, s.devoice
        FROM $workerAlias.term_meta_pitch_staging_table s
      ''');

      // Link Meta -> Pitch
      await targetDb.customStatement('''
        INSERT INTO ${tjPitch.actualTableName} (${tjPitch.termMetaId.name}, ${tjPitch.pitchId.name})
        SELECT $maxMetaId + s.meta_local_id, $maxPitchId + s.pitch_local_id
        FROM $workerAlias.term_meta_pitch_staging_table s
      ''');

      // Link Pitch -> Tags
      await targetDb.customStatement('''
        INSERT INTO ${tjPitchTag.actualTableName} (${tjPitchTag.pitchId.name}, ${tjPitchTag.tagId.name})
        SELECT $maxPitchId + s.parent_local_id, t.id
        FROM $workerAlias.term_meta_tag_staging_table s
        JOIN ${tTag.actualTableName} t ON t.name = s.tag_name AND t.index_id = $indexId
        WHERE s.parent_type = 'pitch'
      ''');

      // 4. Insert IPA
      await targetDb.customStatement('''
        INSERT INTO ${tIpa.actualTableName} (${tIpa.id.name}, ${tIpa.ipa.name})
        SELECT $maxIpaId + s.ipa_local_id, s.ipa
        FROM $workerAlias.term_meta_ipa_staging_table s
      ''');

      // Link Meta -> IPA
      await targetDb.customStatement('''
        INSERT INTO ${tjIpa.actualTableName} (${tjIpa.termMetaId.name}, ${tjIpa.ipaId.name})
        SELECT $maxMetaId + s.meta_local_id, $maxIpaId + s.ipa_local_id
        FROM $workerAlias.term_meta_ipa_staging_table s
      ''');

       // Link IPA -> Tags
      await targetDb.customStatement('''
        INSERT INTO ${tjIpaTag.actualTableName} (${tjIpaTag.ipaId.name}, ${tjIpaTag.tagId.name})
        SELECT $maxIpaId + s.parent_local_id, t.id
        FROM $workerAlias.term_meta_tag_staging_table s
        JOIN ${tTag.actualTableName} t ON t.name = s.tag_name AND t.index_id = $indexId
        WHERE s.parent_type = 'ipa'
      ''');

    }
    finally {
    }
  }
}