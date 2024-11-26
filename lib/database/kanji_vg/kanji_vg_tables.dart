
import 'package:dakanji_db/converters/zlib_text_converter.dart';
import 'package:drift/drift.dart';



/// Contains the kanji entries and links to the radicals table
@TableIndex(name: 'kanjiVGKanji', columns: {#kanjiVGKanji})
class KanjiVGTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the kanji character of this entry
  /// 
  /// **Note:** this column is indexed
  TextColumn get kanjiVGKanji => text().withLength(min: 1)();

  /// The svg data of this kanji
  BlobColumn get kanjiVGSVG => blob().map(const CompressedStringConverter())();
}
