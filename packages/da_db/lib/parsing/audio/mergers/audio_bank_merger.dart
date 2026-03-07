import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/staging_db/mergers/staging_merger.dart';




/// Merges the audio staging database into the main application database.
/// 
/// This merger executes raw SQL `INSERT INTO ... SELECT` statements for maximum 
/// performance. It handles the generation of unique IDs dynamically using SQLite 
/// window functions (`ROW_NUMBER() OVER`) to perfectly map the flat staging data 
/// into the highly relational structure of the main database.
class AudioBankMerger implements StagingMerger { 
  
  @override 
  Future<void> merge({
    required DaDb targetDb,
    required String workerAlias,
    required int indexId,
  }) async {

    // Retrieve the current highest IDs to calculate offsets for new rows
    final int maxAudioId = (await targetDb.audioDao.maxAudioId());
    final int maxMediaId = (await targetDb.mediaDao.maxMediaId());
    final int maxTermId = await targetDb.termDao.maxTermId();
    final int maxReadingId = await targetDb.readingDao.maxReadingId();

    final tTerm = targetDb.termTable;
    final tReading = targetDb.readingTable;
    final tMedia = targetDb.mediaTable;
    final tAudio = targetDb.audioTable;
    final tjAudioTerm = targetDb.audioTableXTermTable;

    await targetDb.transaction(() async {
      
      // --- 1. Core Strings (Terms) ---
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
      await targetDb.customStatement('''
        INSERT INTO fts_terms(rowid, term, term_normalized)
        SELECT id, term, term_normalized FROM ${tTerm.actualTableName} WHERE id > $maxTermId
      ''');

      // --- 2. Search Index (FTS5) ---
      await targetDb.customStatement('''
        INSERT INTO fts_tokens (rowid, tokens, tokens_normalized)
        SELECT DISTINCT 
          t.${tTerm.id.name}, 
          s.term_tokens, 
          s.term_tokens_normalized
        FROM $workerAlias.audio_staging_table s
        JOIN ${tTerm.actualTableName} t ON t.${tTerm.term.name} = s.term
        WHERE 
          s.term_tokens IS NOT NULL
          AND trim(s.term_tokens) != ''
          AND s.term_tokens != s.term
          AND t.${tTerm.id.name} > $maxTermId
      ''');

      // --- 3. Core Strings (Readings) ---
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
      await targetDb.customStatement('''
        INSERT INTO fts_readings(rowid, reading, reading_normalized)
        SELECT id, reading, reading_normalized FROM ${tReading.actualTableName} WHERE id > $maxReadingId
      ''');

      // --- 4. Binary Media ---
      // Assigns a unique, incrementing ID to every file processed in the staging DB.
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

      // --- 5. Audio Metadata ---
      // Links the binary media back to its phonetic reading and pitch accent data.
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

      // --- 6. Junction Table (Many-to-Many Link) ---
      // Resolves the link between the audio entry and the terms it represents.
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