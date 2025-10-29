
import 'package:dakanji_db_core/helper/zlib_text_converter_io.dart';
import 'package:drift/drift.dart';

import '/database/general_tables/kanji_tables.dart';



/// Contains the kanji entries and links to the radicals table
@TableIndex(name: 'KanjiVGTable_kanjiIdIndex', columns: {#kanjiId})
class KanjiVGTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// The id of the kanji character in the `KanjiTable`
  IntColumn get kanjiId => integer().references(KanjiTable, #id)();

  /// The svg data of this kanji
  BlobColumn get svg => blob().map(const ZlibStringConverter())();

}
