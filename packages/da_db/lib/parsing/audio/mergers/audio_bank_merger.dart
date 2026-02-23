import 'package:da_db/database/da_db.dart';

class AudioBankMerger {
  
  Future<void> merge({
    required DaKanjiDB targetDb,
    required String workerAlias,
    required int indexId,
  }) async {

    final int maxAudioId = (await targetDb.audioDao.maxAudioId());
    final int maxMediaId = (await targetDb.mediaDao.maxMediaId());

    final tTerm = targetDb.termTable;
    final tReading = targetDb.readingTable;
    final tMedia = targetDb.mediaTable;
    final tAudio = targetDb.audioTable;
    final tjAudioTerm = targetDb.audioTableXTermTable;

    await targetDb.transaction(() async {
      
      // 2. Insert Terms
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tTerm.actualTableName} (
          ${tTerm.term.name}, 
          ${tTerm.termNormalized.name}
        )
        SELECT DISTINCT 
          term, 
          term_normalized
        FROM $workerAlias.audio_staging_table
      ''');

      // 2.1 Insert Tokens (FTS)
      await targetDb.customStatement('''
        INSERT INTO fts_tokens (rowid, tokens, tokens_normalized)
        SELECT DISTINCT  -- <--- ADDED DISTINCT to prevent rowid crashes
          t.${tTerm.id.name}, 
          s.term_tokens, 
          s.term_tokens_normalized
        FROM $workerAlias.audio_staging_table s
        JOIN ${tTerm.actualTableName} t ON t.${tTerm.term.name} = s.term
        WHERE 
          s.term_tokens IS NOT NULL
          AND trim(s.term_tokens) != ''
          AND s.term_tokens != s.term
          AND NOT EXISTS (
            SELECT 1 FROM fts_tokens WHERE rowid = t.${tTerm.id.name}
          )
      ''');

      // 3. Insert Readings
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tReading.actualTableName} (
          ${tReading.reading.name},
          ${tReading.readingNormalized.name}
        )
        SELECT DISTINCT 
          reading, 
          reading_normalized 
        FROM $workerAlias.audio_staging_table 
        WHERE reading IS NOT NULL
      ''');

      // 4. Insert Media (One row per file)
      await targetDb.customStatement('''
        INSERT INTO ${tMedia.actualTableName} (
          ${tMedia.id.name}, 
          ${tMedia.data.name}, 
          ${tMedia.indexId.name},
          ${tMedia.path.name},
          ${tMedia.name.name}
        )
        SELECT 
           $maxMediaId + ROW_NUMBER() OVER (ORDER BY local_id),
           content,
           $indexId,
           clean_path,
           clean_name
        FROM $workerAlias.media_staging_table
      ''');

      // 5. Insert Audio Entries (One Entry per Media File)
      await targetDb.customStatement('''
        INSERT INTO ${tAudio.actualTableName} (
          ${tAudio.id.name}, 
          ${tAudio.indexId.name}, 
          ${tAudio.readingId.name}, 
          ${tAudio.mediaId.name}, 
          ${tAudio.pitchAccentPattern.name}
        )
        SELECT 
           $maxAudioId + m_rank.rn, 
           $indexId,
           r.${tReading.id.name},
           $maxMediaId + m_rank.rn, 
           meta.pitch_pattern
        FROM $workerAlias.media_staging_table m
        -- Calculate Rank/ID for this file
        JOIN (
            SELECT local_id, ROW_NUMBER() OVER (ORDER BY local_id) as rn 
            FROM $workerAlias.media_staging_table
        ) m_rank ON m.local_id = m_rank.local_id
        -- Get Metadata (Group by file to handle multiple terms sharing one file)
        LEFT JOIN (
            SELECT original_file_name, MAX(reading) as reading, MAX(pitch_pattern) as pitch_pattern
            FROM $workerAlias.audio_staging_table
            GROUP BY original_file_name
        ) meta ON meta.original_file_name = m.file_name
        LEFT JOIN ${tReading.actualTableName} r ON r.${tReading.reading.name} = meta.reading
      ''');

      // 6. Link Audio -> Terms (Many-to-Many)
      await targetDb.customStatement('''
        INSERT INTO ${tjAudioTerm.actualTableName} (${tjAudioTerm.audioId.name}, ${tjAudioTerm.termId.name})
        SELECT 
           $maxAudioId + m_rank.rn, 
           t.${tTerm.id.name}
        FROM $workerAlias.audio_staging_table a
        -- Join Media to get the Rank/ID associated with this file
        JOIN (
            SELECT file_name, ROW_NUMBER() OVER (ORDER BY local_id) as rn 
            FROM $workerAlias.media_staging_table
        ) m_rank ON m_rank.file_name = a.original_file_name
        -- Join Term to get the Term ID
        JOIN ${tTerm.actualTableName} t ON t.${tTerm.term.name} = a.term
        GROUP BY m_rank.rn, t.${tTerm.id.name}
      ''');
    });
  }
}