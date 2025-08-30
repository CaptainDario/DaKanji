// Package imports:
import 'package:drift/drift.dart';



/// Contains the laguage codes
@TableIndex(name: 'languageCode', columns: {#languageCode})
class LanguageCodeTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the example of this entry
  TextColumn get languageCode => text().unique()();

}