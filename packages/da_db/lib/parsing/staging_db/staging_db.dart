import 'package:da_db/parsing/staging_db/tables/audio_staging_tables.dart';
import 'package:da_db/parsing/staging_db/tables/example_staging_tables.dart';
import 'package:da_db/parsing/staging_db/tables/kanji_meta_staging_tables.dart';
import 'package:da_db/parsing/staging_db/tables/kanji_staging_tables.dart';
import 'package:da_db/parsing/staging_db/tables/media_staging_tables.dart';
import 'package:da_db/parsing/staging_db/tables/tag_staging_tables.dart';
import 'package:da_db/parsing/staging_db/tables/term_meta_staging_tables.dart';
import 'package:da_db/parsing/staging_db/tables/term_staging_tables.dart';
// ignore: unused_import -- Needed for generated code
import 'package:da_db/util/data_converters/sql_nullable_json_converter.dart';
// ignore: unused_import -- Needed for generated code
import 'package:da_db/util/data_converters/zlib_text_converter_io.dart';
import 'package:drift/drift.dart';

part 'staging_db.g.dart';

@DriftDatabase(
  tables: [
    // tag
    TagStagingTable,
    // term
    TermStagingTable, TermDefinitionStagingTable, TermTagStagingTable, TermRuleStagingTable,
    // term meta
    TermMetaStagingTable, TermMetaPitchStagingTable, TermMetaIpaStagingTable, TermMetaTagStagingTable,
    // Kanji
    KanjiStagingTable, KanjiReadingStagingTable, KanjiDefinitionStagingTable, KanjiTagStagingTable, KanjiStatStagingTable,
    // Kanji Meta
    KanjiMetaStagingTable,
    // audio
    AudioStagingTable, MediaStagingTable,
    // examples
    ExampleStagingTable, ExampleTagStagingTable, ExampleStatStagingTable, 
    ExampleAudioStagingTable, ExampleAudioTagStagingTable, ExampleAudioStatStagingTable
  ]
)
class StagingDatabase extends _$StagingDatabase {
  StagingDatabase(super.e);
  @override
  int get schemaVersion => 1;
}

