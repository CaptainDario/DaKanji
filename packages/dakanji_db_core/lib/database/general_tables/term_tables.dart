
import 'package:drift/drift.dart';

/// Contains the terms in the DB
class TermTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the term of this entry
  TextColumn get term => text().unique()();

  /// the normalized form of the term (省エネ → 省えね)
  TextColumn get termNormalized => text().nullable()();

  /// the term's tokens (space-separated) of this entry
  TextColumn get termTokens => text().unique().nullable()();

  /// the normalized form of the term's tokens (space-separated) of this entry
  TextColumn get termTokensNormalized => text().nullable()();

}
