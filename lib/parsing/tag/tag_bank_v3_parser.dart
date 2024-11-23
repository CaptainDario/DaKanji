import 'dart:convert';
import 'dart:io';

import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:drift/drift.dart';



/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseTagBankv3(File indexJsonPath, DaKanjiDB db) async {

  // read and decode the json
  String jsonString = indexJsonPath.readAsStringSync();
  List jsonList = jsonDecode(jsonString);

  // List of all tags in the database file
  List<TagBankV3TableCompanion> tagComps = [];
  // List of all tag categories in the database file
  List<TagBankV3CategoryTableCompanion> catComps = [];
  // List of all relationships between tags and their category
  List<TagBankV3TagCategoryRelationsTableCompanion> tagCatRelComps = [];

  // local cache of the inserted tag category ids
  Map<String, int> catIds = {};

  int maxTagId = await db.tagBankV3Dao.maxTagId();
  int maxTagCatId = await db.tagBankV3Dao.maxCategoryId();

  // iterate over the json and parse each entry
  for (var tag in jsonList) {
    // check if the category is already in the db
    int? categoryInsertId = await db.tagBankV3Dao.getCategoryId(tag[1])
      ?? catIds[tag[1]];
    // if not add category to the db 
    if(categoryInsertId == null){
      categoryInsertId = ++maxTagCatId;
      catIds[tag[1]] = categoryInsertId;
      catComps.add(TagBankV3CategoryTableCompanion(
        id: Value(categoryInsertId),
        category: Value(tag[1])
      ));
    }
    
    tagComps.add(TagBankV3TableCompanion(
      id: Value(++maxTagId),
      name: Value(tag[0]),
      sortingOrder: Value(tag[2]),
      notes: Value(tag[3]),
      score: Value(tag[4])
    ));

    tagCatRelComps.add(TagBankV3TagCategoryRelationsTableCompanion(
      categoryId: Value(categoryInsertId),
      tagId: Value(maxTagId)
    ));

  }

  // insert into the db
  await db.batch((batch) {
    batch.insertAll(db.tagBankV3Table, tagComps);
    batch.insertAll(db.tagBankV3CategoryTable, catComps);
    batch.insertAll(db.tagBankV3TagCategoryRelationsTable, tagCatRelComps);
  },);

}