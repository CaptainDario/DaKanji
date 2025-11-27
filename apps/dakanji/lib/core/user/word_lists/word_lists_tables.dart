// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:da_kanji_mobile/core/utils/sql_utils.dart';
import 'package:da_kanji_mobile/features/word_lists/model/word_list_types.dart';



/// SQLite table for the wordlists (ie.: folders and word list nodes)
/// NOT the actual word list entries
class WordListNodesTable extends Table {
  
  /// Id of this row
  IntColumn get id => integer().autoIncrement()();
  /// The name of this wordlist entry
  TextColumn get name => text()();
  /// All children IDs
  TextColumn get childrenIDs => text().map(const ListIntConverter())();
  /// The type of this entry
  IntColumn get type => intEnum<WordListNodeType>()();
  /// Is this entry currently expanded
  BoolColumn get isExpanded => boolean().clientDefault(() => false)();

}

/// Table of the actual dict entries that belong to a word lists in a
/// [WordListNodesTable]
class WordListEntriesTable extends Table {

  /// The id of the entry in the corresponding [WordListNodesTable] 
  IntColumn get wordListID => integer()();
  /// The id of this entry in the dictionary
  IntColumn get dictEntryID => integer()();
  /// The date time when this was added
  DateTimeColumn get timeAdded => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {wordListID, dictEntryID};

}
