import 'package:da_db/util/data_converters/sql_nullable_json_converter.dart';
import 'package:drift/drift.dart';

/// Staging table for the main Term Meta entry (Freq, Pitch, IPA root)
class TermMetaStagingTable extends Table {
  IntColumn get localId => integer()();
  TextColumn get term => text()();
  // NLP columns for the term (needed if term doesn't exist yet)
  TextColumn get termNormalized => text().nullable()();
  
  TextColumn get mode => text()(); // 'freq', 'pitch', 'ipa'
  
  // Reading is often shared or specific to the entry
  TextColumn get reading => text().nullable()();
  TextColumn get readingNormalized => text().nullable()();
  
  // Frequency specific
  IntColumn get freqValue => integer().nullable()();
  TextColumn get freqDisplay => text().nullable()();
}

/// Staging table for Pitch details
class TermMetaPitchStagingTable extends Table {
  IntColumn get pitchLocalId => integer()();
  IntColumn get metaLocalId => integer()(); // FK to TermMetaStagingTable.localId
  TextColumn get position => text()();
  TextColumn get nasal => text().map(const NullableJsonConverter()).nullable()();
  TextColumn get devoice => text().map(const NullableJsonConverter()).nullable()();
}

/// Staging table for IPA details
class TermMetaIpaStagingTable extends Table {
  IntColumn get ipaLocalId => integer()();
  IntColumn get metaLocalId => integer()(); // FK to TermMetaStagingTable.localId
  TextColumn get ipa => text()();
}

/// Staging table for Tags attached to Pitch or IPA entries
class TermMetaTagStagingTable extends Table {
  IntColumn get parentLocalId => integer()(); // Points to pitchLocalId or ipaLocalId
  TextColumn get parentType => text()();      // 'pitch' or 'ipa'
  TextColumn get tagName => text()();
}