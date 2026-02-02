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

  /// Get a stream of all available search profiles (for the dropdown list).
  Stream<List<SearchProfilesEntry>> watchAllProfiles() {
    return (select(searchProfilesTable)
      ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
      .watch()
      .map((rows) => rows
        .map((row) => SearchProfilesEntry.fromSearchProfilesTableData(row))
      .toList());
  }

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

  /// Moves a profile from [oldIndex] to [newIndex] and updates the sort orders in the DB.
  Future<void> reorderProfiles(int oldIndex, int newIndex) async {
    return transaction(() async {
      // 1. Fetch current order (ids only)
      final currentRows = await (select(searchProfilesTable)
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();
      
      final ids = currentRows.map((row) => row.id).toList();

      // 2. Adjust indices (Standard Flutter Reorder logic)
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      // 3. Perform the swap
      if (oldIndex >= 0 && oldIndex < ids.length && newIndex >= 0 && newIndex <= ids.length) {
        final movedId = ids.removeAt(oldIndex);
        ids.insert(newIndex, movedId);

        // 4. Update the sortOrder for all affected rows
        // We update all to ensure consistency, or you could optimize to update only the range affected
        for (int i = 0; i < ids.length; i++) {
          await (update(searchProfilesTable)
                ..where((t) => t.id.equals(ids[i])))
              .write(SearchProfilesTableCompanion(sortOrder: Value(i)));
        }
      }
    });
  }
  
  /// Creates a new profile and automatically assigns the next sortOrder.
  Future<int> createNewProfile(bool isActiveProfile) {
    return transaction(() async {
      // 1. Efficiently query only the maximum sortOrder
      final maxSortOrderExpr = searchProfilesTable.sortOrder.max();
      final result = await (selectOnly(searchProfilesTable)
            ..addColumns([maxSortOrderExpr]))
          .map((row) => row.read(maxSortOrderExpr))
          .getSingle();

      final nextSortOrder = (result ?? -1) + 1;

      // 2. Generate a Name
      final countExpr = searchProfilesTable.id.count();
      final count = await (selectOnly(searchProfilesTable)..addColumns([countExpr]))
          .map((row) => row.read(countExpr))
          .getSingle() ?? 0;
      
      final newName = "Profile ${count + 1}";

      // 3. Get defaults from the Entry class
      const defaults = SearchProfilesEntry();

      // 4. Insert with ALL required columns
      return into(searchProfilesTable).insert(
        SearchProfilesTableCompanion(
          name: Value(newName),
          sortOrder: Value(nextSortOrder),
          isActiveProfile: Value(isActiveProfile),
          
          // Provide values for columns that don't have SQL defaults
          firstSortOrder: Value(defaults.firstSortOrder),
          secondSortOrder: Value(defaults.secondSortOrder),
          groupingRules: Value(defaults.groupingRules),
        ),
      );
    });
  }

  /// DELETE: Strictly forbids deleting the last profile.
  /// Returns [true] if deleted, [false] if the operation was blocked.
  Future<bool> deleteProfile(int id) {
    return transaction(() async {
      // 1. Check strict constraints BEFORE deleting
      final allProfiles = await select(searchProfilesTable).get();
      
      // Must never result in 0 profiles
      if (allProfiles.length <= 1) return false;

      // delete
      await (delete(searchProfilesTable)..where((t) => t.id.equals(id))).go();

      // if this profile was the active profile, set the next profile to active
      final profileToDeleteIdx = allProfiles.indexWhere((e) => e.id == id);
      if (allProfiles[profileToDeleteIdx].isActiveProfile) {
        final profileToUpdate = allProfiles.firstWhere((e) => !e.isActiveProfile && e.id != id);
        await switchActiveProfile(profileToUpdate.id);
      }

      return true;
    });
  }

}
