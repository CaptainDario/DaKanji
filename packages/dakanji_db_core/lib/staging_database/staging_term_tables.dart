import 'package:dakanji_db_core/util/data_converters/zlib_text_converter_io.dart';
import 'package:drift/drift.dart';



class StagingTermTable extends Table {
  IntColumn get localId => integer().autoIncrement()();
  TextColumn get term => text()();
  TextColumn get reading => text()();
  TextColumn get termNormalized => text().nullable()();
  TextColumn get termTokens => text().nullable()();
  TextColumn get termTokensNormalized => text().nullable()();
  TextColumn get readingNormalized => text().nullable()();
  IntColumn get popularity => integer()();
  IntColumn get sequenceNumber => integer()();
  BlobColumn get originalJson => blob().map(const ZlibStringConverter()).nullable()(); 
}

class StagingDefinitionTable extends Table {
  IntColumn get termLocalId => integer()();
  TextColumn get definition => text()();
}

class StagingTagTable extends Table {
  IntColumn get termLocalId => integer()();
  TextColumn get tagName => text()();
  BoolColumn get isDefinitionTag => boolean()();
}

class StagingRuleTable extends Table {
  IntColumn get termLocalId => integer()();
  TextColumn get ruleId => text()();
}