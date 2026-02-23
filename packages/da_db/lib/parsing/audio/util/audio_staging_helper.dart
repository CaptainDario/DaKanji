import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:drift/drift.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;
import 'package:unorm_dart/unorm_dart.dart' as unorm;

class AudioStagingHelper {
  final StagingDatabase stagingDb;
  final DaKanjiDB mainDb;
  final Function(String) onStatus;

  final List<AudioStagingTableCompanion> _audioRows = [];
  final List<MediaStagingTableCompanion> _mediaRows = [];

  AudioStagingHelper({
    required this.stagingDb,
    required this.mainDb,
    required this.onStatus,
  });

  Future<void> addEntry({
    required List<String> terms,
    required String? reading,
    required int? pitchPattern,
    required String originalFilePath,
    required Uint8List fileContent,
  }) async {
    
    // --- Ter/Reading ---
    // Process Reading
    String? readingNormalized;
    if (reading != null) {
      readingNormalized = mainDb.languageProcessor
          .normalize(reading, ProcessorOptions())
          .firstOrNull;
      
      if (readingNormalized == reading) readingNormalized = null;
    }

    // Process Terms
    for (final term in terms) {
      // Normalize Term
      String? termNormalized = mainDb.languageProcessor
        .normalize(term, ProcessorOptions())
        .firstOrNull;
      
      if (termNormalized == term) termNormalized = null;

      // Segment Term
      String? termTokens = mainDb.languageProcessor.segment(term);
      
      // Normalize Tokens
      String? termTokensNormalized;
      if (termTokens != null) {
        termTokensNormalized = mainDb.languageProcessor
          .normalize(termTokens, ProcessorOptions())
          .firstOrNull;
        
        if (termTokensNormalized == termTokens) termTokensNormalized = null;
      }

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

    // --- Path ---
    final rawName = p.basename(originalFilePath);
    final rawDir = p.dirname(originalFilePath);
    
    // Normalize path and name to NFC
    final cleanName = unorm.nfc(rawName);
    final cleanPath = unorm.nfc(rawDir);
    
    _mediaRows.add(MediaStagingTableCompanion(
      fileName: Value(originalFilePath),
      cleanPath: Value(cleanPath),
      cleanName: Value(cleanName),
      content: Value(fileContent),
    ));

    if (_mediaRows.length >= 200) {
      await flush();
    }
  }

  Future<void> flush() async {
    if (_mediaRows.isEmpty && _audioRows.isEmpty) return;

    await stagingDb.batch((batch) {
      if (_audioRows.isNotEmpty) {
        batch.insertAll(stagingDb.audioStagingTable, _audioRows);
      }
      if (_mediaRows.isNotEmpty) {
        batch.insertAll(stagingDb.mediaStagingTable, _mediaRows);
      }
    });

    _audioRows.clear();
    _mediaRows.clear();
  }
}