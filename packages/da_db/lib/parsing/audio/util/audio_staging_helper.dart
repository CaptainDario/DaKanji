import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:drift/drift.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;
import 'package:unorm_dart/unorm_dart.dart' as unorm;

/// Formats, normalizes, and batches raw audio data into the Staging Database.
/// 
/// **Architectural Note:** This class relies on an isolated `LanguageProcessor` 
/// instance rather than the main `DaDb` instance. Passing the main database into 
/// the isolate would cause SQLite connection locking issues.
class AudioStagingHelper {
  final StagingDatabase stagingDb;
  final LanguageProcessor lp; 
  final Function(String) onStatus;

  final List<AudioStagingTableCompanion> _audioRows = [];
  final List<MediaStagingTableCompanion> _mediaRows = [];

  AudioStagingHelper({
    required this.stagingDb,
    required this.lp,
    required this.onStatus,
  });

  /// Normalizes linguistic data (NFC formatting, tokenization) and queues 
  /// the binary media file for batch insertion.
  Future<void> addEntry({
    required List<String> terms,
    required String? reading,
    required int? pitchPattern,
    required String originalFilePath,
    required Uint8List fileContent,
  }) async {
    
    // --- 1. Phonetic Normalization ---
    String? readingNormalized;
    if (reading != null) {
      readingNormalized = lp.normalize(reading, const ProcessorOptions()).firstOrNull;
      if (readingNormalized == reading) readingNormalized = null;
    }

    // --- 2. Term NLP Processing ---
    for (final term in terms) {
      String? termNormalized = lp.normalize(term, const ProcessorOptions()).firstOrNull;
      if (termNormalized == term) termNormalized = null;

      String? termTokens = lp.parse(term, const ProcessorOptions()).segments.nonNulls.join(" ");
      String? termTokensNormalized;
      termTokensNormalized = lp.normalize(termTokens, const ProcessorOptions()).firstOrNull;
      if (termTokensNormalized == termTokens) termTokensNormalized = null;

      _audioRows.add(AudioStagingTableCompanion(
        term: Value(term),
        termNormalized: Value(termNormalized),
        termTokens: Value(termTokens),
        termTokensNormalized: Value(termTokensNormalized),
        reading: Value(reading),
        readingNormalized: Value(readingNormalized),
        pitchPattern: Value(pitchPattern),
        originalFileName: Value(originalFilePath),
      ));
    }

    // --- 3. Path & File Normalization ---
    final rawName = p.basename(originalFilePath);
    final rawDir = p.dirname(originalFilePath);
    final cleanName = unorm.nfc(rawName);
    final cleanPath = unorm.nfc(rawDir);
    
    _mediaRows.add(MediaStagingTableCompanion(
      fileName: Value(originalFilePath),
      cleanPath: Value(cleanPath),
      cleanName: Value(cleanName),
      content: Value(fileContent),
    ));

    // Flush to disk iteratively to maintain a flat memory footprint
    if (_mediaRows.length >= 200) {
      await flush();
    }
  }

  /// Writes all queued rows to the staging SQLite database inside a transaction.
  Future<void> flush() async {
    if (_mediaRows.isEmpty && _audioRows.isEmpty) return;
    
    await stagingDb.batch((batch) {
      if (_audioRows.isNotEmpty) batch.insertAll(stagingDb.audioStagingTable, _audioRows);
      if (_mediaRows.isNotEmpty) batch.insertAll(stagingDb.mediaStagingTable, _mediaRows);
    });
    
    _audioRows.clear();
    _mediaRows.clear();
  }
}