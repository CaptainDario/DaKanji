import 'package:da_db/database/example/example_tables.dart';
import 'package:da_db/database/general_tables/term_tables.dart';
import 'package:da_db/database/stats/stat_tables.dart';
import 'package:da_db/database/tag/tag_bank_v3_tables.dart';
import 'package:drift/drift.dart';

/// Contains the relationships between example sentences and their associated audio files.
@TableIndex(name: 'ExampleTable_X_ExampleAudioTable_audioIdIndex', columns: {#audioId})
// ignore: camel_case_types
class ExampleTable_X_ExampleAudioTable extends Table {
  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {exampleId, audioId};

  /// The ID of the example sentence entry.
  IntColumn get exampleId => integer()
    .references(ExampleTable, #id, onDelete: KeyAction.cascade)();
      
  /// The ID of the audio entry.
  IntColumn get audioId => integer()
    .references(ExampleAudioTable, #id, onDelete: KeyAction.cascade)();
}

/// Contains the relationships between example sentences and the dictionary terms they contain.
@TableIndex(name: 'ExampleSentenceTable_X_TermTable_TermIdIndex', columns: {#termId})
// ignore: camel_case_types
class ExampleSentenceTable_X_TermTable extends Table {
  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {exampleSentenceId, termId};

  /// The ID of the example sentence entry.
  IntColumn get exampleSentenceId => integer()
    .references(ExampleSentenceTable, #id, onDelete: KeyAction.cascade)();
      
  /// The ID of the dictionary term entry.
  IntColumn get termId => integer()
    .references(TermTable, #id, onDelete: KeyAction.cascade)();
}

/// Links example sentences to their deduplicated stats in the StatTable.
@TableIndex(name: 'ExampleTable_X_StatTable_statIdIndex', columns: {#statTableId})
// ignore: camel_case_types
class ExampleTable_X_StatTable extends Table {
  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {exampleId, statTableId};

  /// The ID of the example sentence.
  IntColumn get exampleId => integer()
    .references(ExampleTable, #id, onDelete: KeyAction.cascade)();

  /// The ID of the deduplicated stat combination in the StatTable.
  IntColumn get statTableId => integer()
    .references(StatTable, #id, onDelete: KeyAction.cascade)();
}

/// Links example audio files to their deduplicated stats in the StatTable.
@TableIndex(name: 'ExampleAudioTable_X_StatTable_statIdIndex', columns: {#statTableId})
// ignore: camel_case_types
class ExampleAudioTable_X_StatTable extends Table {
  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {audioId, statTableId};

  /// The ID of the audio file entry.
  IntColumn get audioId => integer()
      .references(ExampleAudioTable, #id, onDelete: KeyAction.cascade)();

  /// The ID of the deduplicated stat combination in the StatTable.
  IntColumn get statTableId => integer()
      .references(StatTable, #id, onDelete: KeyAction.cascade)();
}

/// Links example sentences to their deduplicated tags in the TagBank.
@TableIndex(name: 'ExampleTable_X_TagBankTable_tagIdIndex', columns: {#tagBankId})
// ignore: camel_case_types
class ExampleTable_X_TagBankTable extends Table {
  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {exampleId, tagBankId};

  /// The ID of the example sentence.
  IntColumn get exampleId => integer()
      .references(ExampleTable, #id, onDelete: KeyAction.cascade)();

  /// The ID of the tag in the TagBank.
  IntColumn get tagBankId => integer()
      .references(TagBankV3Table, #id, onDelete: KeyAction.cascade)();
}

/// Links example audio files to their deduplicated tags in the TagBank.
@TableIndex(name: 'ExampleAudioTable_X_TagBankTable_tagIdIndex', columns: {#tagBankId})
// ignore: camel_case_types
class ExampleAudioTable_X_TagBankTable extends Table {
  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {audioId, tagBankId};

  /// The ID of the audio file entry.
  IntColumn get audioId => integer()
      .references(ExampleAudioTable, #id, onDelete: KeyAction.cascade)();

  /// The ID of the tag in the TagBank.
  IntColumn get tagBankId => integer()
      .references(TagBankV3Table, #id, onDelete: KeyAction.cascade)();
}