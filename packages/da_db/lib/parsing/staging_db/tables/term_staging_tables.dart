import 'package:da_db/util/data_converters/zlib_text_converter_io.dart';
import 'package:drift/drift.dart';



class TermStagingTable extends Table {
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
  TextColumn get definitionJsonHash => text().nullable()();
}

class TermDefinitionStagingTable extends Table {
  IntColumn get termLocalId => integer()();
  TextColumn get definition => text()();
  IntColumn get rank => integer()();
}

class TermTagStagingTable extends Table {
  IntColumn get termLocalId => integer()();
  TextColumn get tagName => text()();
  BoolColumn get isDefinitionTag => boolean()();
}

class TermRuleStagingTable extends Table {
  IntColumn get termLocalId => integer()();
  TextColumn get ruleId => text()();
}