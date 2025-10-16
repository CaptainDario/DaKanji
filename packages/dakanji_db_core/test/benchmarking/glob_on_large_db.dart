import 'dart:io';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

// A simple benchmark runner.
void benchmark(String name, void Function() function) {
  final stopwatch = Stopwatch()..start();
  function();
  stopwatch.stop();
  print('$name: ${stopwatch.elapsedMilliseconds}ms');
}

void main() {
  final dbPath = p.join(Directory.current.path, 'benchmark.db');
  final compressedDbPath = p.join(Directory.current.path, 'benchmark_compressed.db');
  final dbFile = File(dbPath);
  final compressedDbFile = File(compressedDbPath);

  if (dbFile.existsSync()) {
    dbFile.deleteSync();
  }
  if (compressedDbFile.existsSync()) {
    compressedDbFile.deleteSync();
  }

  // Open both databases from files.
  final db = sqlite3.open(dbPath);
  final compressedDb = sqlite3.open(compressedDbPath);
  print('Using sqlite3');

  // ----------------------------------------------------------------------
  // 1. Create Tables & Index
  // ----------------------------------------------------------------------
  benchmark('Table Creation (Uncompressed)', () {
    db.execute('CREATE TABLE documents (id INTEGER PRIMARY KEY, content TEXT NOT NULL);');
  });

  benchmark('Index Creation (Uncompressed)', () {
    // This index will dramatically speed up prefix searches (e.g., 'pattern*').
    // It will NOT speed up infix searches (e.g., '*pattern*').
    db.execute('CREATE INDEX idx_content ON documents (content);');
  });
  
  benchmark('Table Creation (Compressed)', () {
    // Use BLOB type to store the compressed binary data.
    compressedDb.execute('CREATE TABLE documents (id INTEGER PRIMARY KEY, content BLOB NOT NULL);');
  });

  // ----------------------------------------------------------------------
  // 2. Data Insertion
  // ----------------------------------------------------------------------
  final totalEntries = 10_000_000;
  print('\nPreparing to insert $totalEntries entries into both databases...');

  benchmark('Data Insertion ($totalEntries entries to both DBs)', () {
    // Use a transaction for significantly faster insertions.
    db.execute('BEGIN TRANSACTION;');
    compressedDb.execute('BEGIN TRANSACTION;');

    final stmt = db.prepare('INSERT INTO documents (content) VALUES (?)');
    final compressedStmt = compressedDb.prepare('INSERT INTO documents (content) VALUES (?)');
    final zlibEncoder = ZLibEncoder();

    try {
      for (int i = 0; i < totalEntries; i++) {
        // Generate varied text data to search against.
        String content;

        // For infix search: ~0.01% of entries will contain the pattern. (500 matches)
        if (i % 10000 == 0) {
          content = 'entry_${i}_some_data_abc_pattern_xyz_and_more_data_end';
        // For prefix search: ~0.01% of entries will start with the pattern. (500 matches)
        } else if (i % 10000 == 1) {
          content = 'pattern_is_at_start_of_entry_${i}';
        } else {
          content = 'entry_${i}_no_match_for_benchmark_end';
        }
        
        // Insert uncompressed data into the first DB
        stmt.execute([content]);
        
        // Compress data and insert as a BLOB into the second DB
        final compressedData = zlibEncoder.encode(content.codeUnits);
        compressedStmt.execute([compressedData]);

        if (i % 500000 == 0 && i > 0) {
            print('  ... inserted $i entries');
        }
      }
      db.execute('COMMIT;');
      compressedDb.execute('COMMIT;');
       print('  ... inserted $totalEntries entries');
    } catch (e) {
      print('Error during insertion: $e');
      db.execute('ROLLBACK;');
      compressedDb.execute('ROLLBACK;');
    } finally {
      stmt.dispose();
      compressedStmt.dispose();
    }
  });

  // ----------------------------------------------------------------------
  // 3. GLOB Benchmark (on uncompressed DB)
  // ----------------------------------------------------------------------
  print('\nRunning GLOB search benchmark on uncompressed database...');
  int infixFoundCount = 0;
  int prefixFoundCount = 0;
  
  String globPattern = '*pattern*';

  benchmark('GLOB Infix Search ("$globPattern" - Unindexed)', () {
    final resultSet = db.select('SELECT * FROM documents WHERE content GLOB ?', [globPattern]);
    infixFoundCount = resultSet.length;
  });
  print('Found $infixFoundCount entries matching the infix pattern.');


  globPattern = 'pattern*';
  benchmark('GLOB Prefix Search ("$globPattern" - Indexed)', () {
    final resultSet = db.select('SELECT * FROM documents WHERE content GLOB ?', [globPattern]);
    prefixFoundCount = resultSet.length;
  });
  print('Found $prefixFoundCount entries matching the prefix pattern.');
  
  // ----------------------------------------------------------------------
  // 4. Cleanup
  // ----------------------------------------------------------------------
  db.dispose();
  compressedDb.dispose();
}

