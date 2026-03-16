import 'package:drift/drift.dart';

class TagStagingTable extends Table {
  TextColumn get tagName => text()();
  TextColumn get category => text()();
  IntColumn get sortingOrder => integer()();
  TextColumn get notes => text()();
  IntColumn get score => integer()();
}