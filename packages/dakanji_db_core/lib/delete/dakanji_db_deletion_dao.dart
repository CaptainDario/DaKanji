import "package:dakanji_db_core/database/dakanji_db.dart";
import "package:dakanji_db_core/database/dictionary_types.dart";
import "package:dakanji_db_core/delete/audio_delete.dart";
import "package:dakanji_db_core/delete/examples_delete.dart";
import "package:dakanji_db_core/delete/yomitan_dictionary_delete.dart";
import "package:drift/drift.dart";

part 'dakanji_db_deletion_dao.g.dart';

// Dao class that contains all queries related to the `KanjiTable`
@DriftAccessor()
class Deletion extends DatabaseAccessor<DaKanjiDB> with _$DeletionMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  Deletion(super.db);

  Future deleteDictionary(int indexId) async {

    var indexEntry = (await db.indexDao.getById(indexId));
    
    switch (indexEntry!.dictionaryType) {
      case DictionaryTypes.yomitan:
        await deleteyomitanDictionary(db, indexId);
        break;
      case DictionaryTypes.examples:
        await deleteExamplesDictionary(db, indexId);
        break;
      case DictionaryTypes.audio:
        await deleteAudioDictionary(db, indexId);
        break;
    }

  }
  
}
