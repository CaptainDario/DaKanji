// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:isar_community/isar.dart';

part 'search_history.g.dart';



/// One search that was made by the user; rebuild *.g.dart by
/// `flutter pub run build_runner build --delete-conflicting-outputs`
@collection
class SearchHistory {
  /// The id of this entry
  Id id = Isar.autoIncrement;
  /// the date when the user searched for this entry
  @Index(type: IndexType.value)
  late DateTime dateSearched;
  /// the id of the dictionary entry that has been searched
  late int dictEntryId;
  /// The schema of the database this entry was searched in
  @enumerated
  DatabaseType schema = DatabaseType.None;
}
