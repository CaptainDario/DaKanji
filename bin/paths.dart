// Package imports:
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

/// the path where the dakanji database should be created and populated
final dakanjiDbPath = p.joinAll([Directory.current.path, "tmp", "dakanji.db"]);

/// Path to the folder that contains the sample from the yomitan repo
final samplesPath = p.joinAll([Directory.current.path, "samples"]);

/// path to the kanjidic2 files that should be parsed
final kanjidic2Path = p.joinAll([Directory.current.path, "stresstest", "KANJIDIC_english"]);
/// path to the kanjivg folder that should be parsed
final kanjiVGPath = p.joinAll([Directory.current.path, "input_files", "kanji"]);
/// path to the radical files that should be parsed
final radicalsPath = p.joinAll([Directory.current.path, "input_files", "radicals"]);
