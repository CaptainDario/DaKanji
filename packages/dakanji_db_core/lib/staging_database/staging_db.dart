
import 'package:dakanji_db_core/staging_database/staging_term_tables.dart';
import 'package:dakanji_db_core/util/data_converters/zlib_text_converter_io.dart';
import 'package:drift/drift.dart';

part 'staging_db.g.dart';

@DriftDatabase(
  tables: [
    StagingTermTable, StagingDefinitionTable, StagingTagTable, StagingRuleTable
  ]
)
class StagingDatabase extends _$StagingDatabase {
  StagingDatabase(super.e);
  @override
  int get schemaVersion => 1;
}

