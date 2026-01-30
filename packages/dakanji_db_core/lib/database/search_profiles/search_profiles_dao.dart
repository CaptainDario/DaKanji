import "package:dakanji_db_core/database/search_profiles/search_profile_tables.dart";
import "package:dakanji_db_core/database/search_profiles/search_profiles_entry.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part 'search_profiles_dao.g.dart';




@DriftAccessor(tables: [
  SearchProfilesTable
])
class SearchProfilesDao extends DatabaseAccessor<DaKanjiDB> with _$SearchProfilesDaoMixin {
  
  SearchProfilesDao(super.db);

  /// 
  Stream<SearchProfilesEntry> watchActiveProfile() {
    return ((select(searchProfilesTable)
        ..where((t) => t.isActiveProfile.equals(true))
        ..limit(1))
      .watchSingle())
      .map((e) => SearchProfilesEntry.fromSearchProfilesTableData(e));
  }

  /// Get current active profile without listening to changes
  Future<SearchProfilesEntry> getActiveProfile() async {
    final data = await (select(searchProfilesTable)
      ..where((t) => t.isActiveProfile.equals(true))
      ..limit(1))
      .getSingle();

    return SearchProfilesEntry.fromSearchProfilesTableData(data);
  }

  /// Updates the values of the *current* profile
  Future<bool> updateProfile(SearchProfilesEntry data) async {
    return await update(searchProfilesTable).replace(data.toSearchProfilesTableData());
  }

  /// Sets a specific profile ID to active and all others to inactive.
  /// This guarantees only one profile is active at a time.
  Future<void> switchActiveProfile(int targetProfileId) {
    return transaction(() async {
      // Step 1: Set ALL profiles to inactive
      await (update(searchProfilesTable))
          .write(const SearchProfilesTableCompanion(isActiveProfile: Value(false)));

      // Step 2: Set the TARGET profile to active
      await (update(searchProfilesTable)..where((t) => t.id.equals(targetProfileId)))
          .write(const SearchProfilesTableCompanion(isActiveProfile: Value(true)));
    });
  }
  
  /// Helper to create a new profile (e.g. "Copy of Standard")
  Future<int> createProfile(SearchProfilesEntry entry) async {
    return await into(searchProfilesTable).insert(entry.toSearchProfilesTableData());
  }

}
