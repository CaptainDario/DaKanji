import 'package:drift/drift.dart';



/// The names and displayNames of the stats (e.g., "Quality", "JLPT",
/// "Frequency")
class StatNameTable extends Table {

  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();

}

/// The actual deduplicated values (Your "Stat Table")
/// e.g., (1, "JLPT N5", 5.0), (1, "JLPT N4", 4.0)
@TableIndex(name: 'StatData_NameValue_Index', columns: {#statNameId, #value})
class StatTable extends Table {

  @override
  List<Set<Column>> get uniqueKeys => [{statNameId, statDisplayNameId, displayValue, value}];

  IntColumn get id => integer().autoIncrement()();
  
  @ReferenceName("StatName_StatNameTable")
  IntColumn get statNameId => integer()
    .references(StatNameTable, #id)();

  @ReferenceName("StatDisplayName_StatNameTable")
  IntColumn get statDisplayNameId => integer().nullable()
    .references(StatNameTable, #id)();

  RealColumn get value => real()();

  TextColumn get displayValue => text().nullable()();
  
}