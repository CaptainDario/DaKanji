// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:dakanji_db/database/general_tables/kanji_tables.dart';
import 'package:dakanji_db/helper/zlib_text_converter.dart';

/// Contains the kanji entries and links to the radicals table
class KanjiVGTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// The id of the kanji character in the `KanjiTable`
  IntColumn get kanjiId => integer().references(KanjiTable, #id)();

  /// The svg data of this kanji
  BlobColumn get kanjiVGSVG => blob().map(const ZlibStringConverter())();

}
