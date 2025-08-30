// Package imports:
import "dart:convert";

import "package:drift/drift.dart";

// Project imports:
import "/database/tag/tag_bank_v3_entry.dart";
import "/database/tag/tag_bank_v3_tables.dart";
import "../dakanji_db.dart";

part 'tag_bank_v3_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [
    TagBankV3Table
])
class TagBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$TagBankV3DaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  TagBankV3Dao(super.db);


  /// 
  Future<TagBankV3Entry> getTagByName(String tagName) async {
    /// TODO
    return TagBankV3Entry.fromJson(jsonDecode(""));
  }


  /// Checks if the given `tag` is already present in the database
  Future<int?> getTagId(String tag) async {

    final result = await db.managers.tagBankV3Table
      .filter((f) => f.name(tag))
      .getSingleOrNull();

    return result?.id;

  }


  /// Get all tags and their ids 
  Future<List<TagBankV3TableData>> getAllTags() async {
    return await select(tagBankV3Table).get();
  }

  /// Get the maximum id of the tag table
  Future<int> maxTagId() async {

    final query = selectOnly(tagBankV3Table)
        ..addColumns([tagBankV3Table.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(tagBankV3Table.id.max()) ?? 0;
  }

}
