import 'dart:io';
import 'package:path/path.dart' as p;



/// the path where the dakanji database should be created and populated
final dakanjiDbPath = p.joinAll([Directory.current.path, "tmp", "dakanji.db"]);

/// path to the kanjidic2 files that should be parsed
final kanjidic2Path = p.joinAll([Directory.current.path, "stresstest", "KANJIDIC_english"]);
/// path to the kanjivg folder that should be parsed
final kanjiVGPath = p.joinAll([Directory.current.path, "input_files", "kanji"]);
/// path to the radical files that should be parsed
final radicalsPath = p.joinAll([Directory.current.path, "input_files", "radicals"]);