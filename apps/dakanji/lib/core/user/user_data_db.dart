import 'dart:io';

import 'package:da_kanji_mobile/core/user/search_history/search_history_dao.dart';
import 'package:da_kanji_mobile/core/user/search_history/search_history_tables.dart';
import 'package:da_kanji_mobile/core/user/stats/dict_stats_table.dart';
import 'package:da_kanji_mobile/core/user/time_tracking/time_tracking_dao.dart';
import 'package:da_kanji_mobile/core/user/time_tracking/time_tracking_table.dart';
import 'package:da_kanji_mobile/core/user/word_lists/word_lists_dao.dart';
import 'package:da_kanji_mobile/core/user/word_lists/word_lists_tables.dart';
import 'package:da_kanji_mobile/core/utils/sql_utils.dart';
import 'package:da_kanji_mobile/features/word_lists/model/word_list_types.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

// neccessary imports to make drift generated code work


part 'user_data_db.g.dart';



@DriftDatabase(
  tables: [
    // word lists
    WordListNodesTable, WordListEntriesTable,

    // search history
    SearchHistoryTable,

    // stats
    DictStatsTable,

    // time tracking
    TimeTrackingTable,
    TimeTrackingUnitTable,
    TimeTrackingCategoriesTable,
    TimeTrackingTagsTable,
    TimeTrackingDailyGoalTable,
  ],
  daos: [
    WordListsDao,
    SearchHistoryDao,

    TimeTrackingDao
  ]
)
class UserDataDB extends _$UserDataDB {

  UserDataDB(
    {
      QueryExecutor? executor,
      String? dbPath
    }
  ) : super(executor ?? _openConnection(dbPath));

  List<String> get getcustomConstraints => [
    'FOREIGN KEY (wordListID, dictEntryID) REFERENCES (wordListID, dictEntryID)'
  ];

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection(String? dbPath) {

    File path = File(dbPath ?? g_DakanjiPathManager.userDataSqlite.path);

    QueryExecutor qe = NativeDatabase.createInBackground(path);

    return qe;
  }
}
