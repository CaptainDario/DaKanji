import 'package:drift/drift.dart';



/// Contains the meanins entries to which other tables link
@TableIndex(name: 'meaning', columns: {#meaning})
class MeaningTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the meaning of this entry
  TextColumn get meaning => text().unique()();

}
