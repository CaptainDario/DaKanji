// Package imports:
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

/// the path where the dakanji database should be created and populated
final dakanjiDbPath = p.joinAll([Directory.current.path, "tmp", "dakanji.db"]);

/// Path to the folder that contains yomitan dictionary samples for development
final devYomitanPath = p.joinAll([Directory.current.path, "samples", "yomitan"]);
/// Path to the folder that contains example sentences for development
final devExampleSentencesPath = p.joinAll([Directory.current.path, "samples", "example_sentences"]);
/// Path to the folder that contains example texts for development
final devExampleTextsPath = p.joinAll([Directory.current.path, "samples", "example_texts"]);

/// path to the kanjidic2 files that should be parsed
final kanjidic2Path = p.joinAll([Directory.current.path, "input_files", "KANJIDIC_english"]);
/// path to the kanjivg folder that should be parsed
final kanjiVGPath = p.joinAll([Directory.current.path, "input_files", "kanji"]);
/// path to the radical files that should be parsed
final radicalsPath = p.joinAll([Directory.current.path, "input_files", "radicals"]);
