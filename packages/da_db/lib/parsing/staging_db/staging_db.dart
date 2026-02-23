import 'package:da_db/parsing/staging_db/audio_staging_tables.dart';
import 'package:da_db/parsing/staging_db/kanji_meta_staging_tables.dart';
import 'package:da_db/parsing/staging_db/kanji_staging_tables.dart';
import 'package:da_db/parsing/staging_db/media_staging_tables.dart';
import 'package:da_db/parsing/staging_db/tag_staging_tables.dart';
import 'package:da_db/parsing/staging_db/term_meta_staging_tables.dart';
import 'package:da_db/parsing/staging_db/term_staging_tables.dart';
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
  ]
)
class StagingDatabase extends _$StagingDatabase {
  StagingDatabase(super.e);
  @override
  int get schemaVersion => 1;
}

