import "package:dakanji_db/database/tag/tag_bank_entry.dart";
import "package:dakanji_db/database/tag/tag_bank_v3_relation_tables.dart";
import "package:dakanji_db/database/tag/tag_bank_v3_tables.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part 'tag_bank_v3_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [
    TagBankV3Table,
    TagBankV3TagCategoryRelationsTable
])
class TagBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$TagBankV3DaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  TagBankV3Dao(super.db);


  /// 
  Future<TagBankEntry> getTagByName(String tagName) async {
    final query = select(tagBankV3Table).join([
      // Join with the tag-category relations table
      innerJoin(
        tagBankV3TagCategoryRelationsTable,
        tagBankV3TagCategoryRelationsTable.tagId.equalsExp(tagBankV3Table.id),
      ),
      // Join with the category table
      innerJoin(
        tagBankV3CategoryTable,
        tagBankV3CategoryTable.id.equalsExp(tagBankV3TagCategoryRelationsTable.categoryId),
      ),
    ])
      ..where(tagBankV3Table.name.equals(tagName)); // Filter by tag name

    final result = await query.map((row) {
      final tag = row.readTable(tagBankV3Table);
      final category = row.readTable(tagBankV3CategoryTable);

      return TagBankEntry(
        name: tagName,
        categories: category.category,
        sortingOrder: tag.sortingOrder,
        notes: tag.notes,
        score: tag.score);
    }).get();

    if(result.length > 1){
      throw Exception("Tag lookup found multiple tags using the same name");
    }

    return result.first;
  }


  /// Checks if the given `tag` is already present in the database
  Future<int?> getTagId(String tag) async {

    final result = await db.managers.tagBankV3Table
      .filter((f) => f.name(tag))
      .getSingleOrNull();

    return result?.id;

  }

  /// Checks if the given `category` is already present in the database
  Future<int?> getCategoryId(String category) async {

    final result = await db.managers.tagBankV3CategoryTable
      .filter((f) => f.category(category))
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

  /// Get the maximum id of the category table
  Future<int> maxCategoryId() async {

    final query = selectOnly(tagBankV3CategoryTable)
        ..addColumns([tagBankV3CategoryTable.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(tagBankV3CategoryTable.id.max()) ?? 0;
  }

}