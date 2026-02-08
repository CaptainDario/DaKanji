import 'package:dakanji_db_core/database/dakanji_db.dart';


class AudioBankMerger {

  Future<void> merge({
    required DaKanjiDB targetDb,
    required String workerAlias,
    required int indexId,
  }) async {
    
    await targetDb.customStatement('PRAGMA cache_size = -200000;');
    await targetDb.customStatement('PRAGMA temp_store = MEMORY;');

    final maxAudioId = await targetDb.audioDao.maxAudioId();
    final maxMediaId = await targetDb.mediaDao.maxMediaId();

    final tTerm = targetDb.termTable;
    final tReading = targetDb.readingTable;
    final tMedia = targetDb.mediaTable;
    final tAudio = targetDb.audioTable;
    final tjAudioTerm = targetDb.audioTableXTermTable;

    try {
      // 1. Insert New Terms
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tTerm.actualTableName} (${tTerm.term.name})
        SELECT DISTINCT term FROM $workerAlias.audio_staging_table
      ''');

      // 2. Insert New Readings
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tReading.actualTableName} (${tReading.reading.name})
        SELECT DISTINCT reading FROM $workerAlias.audio_staging_table 
        WHERE reading IS NOT NULL
      ''');

      // 3. Insert Media (Bulk copy from staging to main)
      // NOTE: We assume the column in MediaTable is named 'media'. 
      // If it is 'content' or 'data', change tMedia.media.name below.
      await targetDb.customStatement('''
        INSERT INTO ${tMedia.actualTableName} (${tMedia.id.name}, ${tMedia.data.name})
        SELECT 
           $maxMediaId + ROW_NUMBER() OVER (ORDER BY local_id),
           content
        FROM $workerAlias.media_staging_table
      ''');

      // 4. Insert Audio Entries
      // Links Reading, Media, and Index
      await targetDb.customStatement('''
        INSERT INTO ${tAudio.actualTableName} (
          ${tAudio.id.name}, ${tAudio.indexId.name}, ${tAudio.readingId.name}, 
          ${tAudio.mediaId.name}, ${tAudio.pitchAccentPattern.name}
        )
        SELECT 
           $maxAudioId + a.local_id,
           $indexId,
           r.${tReading.id.name},
           $maxMediaId + m_rank.rn, -- Corresponds to the ID generated in step 3
           a.pitch_pattern
        FROM $workerAlias.audio_staging_table a
        -- Join Readings
        LEFT JOIN ${tReading.actualTableName} r ON r.${tReading.reading.name} = a.reading
        -- Join Media (Complex join to match the RowNumber generated above)
        JOIN (
            SELECT local_id, ROW_NUMBER() OVER (ORDER BY local_id) as rn, file_name 
            FROM $workerAlias.media_staging_table
        ) m_rank ON m_rank.file_name = a.original_file_name
      ''');

      // 5. Link Audio -> Terms
      await targetDb.customStatement('''
        INSERT INTO ${tjAudioTerm.actualTableName} (${tjAudioTerm.audioId.name}, ${tjAudioTerm.termId.name})
        SELECT 
           $maxAudioId + a.local_id,
           t.${tTerm.id.name}
        FROM $workerAlias.audio_staging_table a
        JOIN ${tTerm.actualTableName} t ON t.${tTerm.term.name} = a.term
      ''');

    } finally {
      // Cleanup
    }
  }
}