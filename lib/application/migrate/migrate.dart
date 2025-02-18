// Project imports:
import 'package:da_kanji_mobile/application/migrate/v3_to_v4.dart';
import 'package:da_kanji_mobile/entities/releases/version.dart';

/// Checks if any migration is necessary and if so runs the them
Future migrate(Version? last, Version current) async {

  // while on >= v3.5.0 backup all word list data to text files to allow 
  // migration to v4
  if(current.major == 3){
    storeWordListsAsTextFilesForMigration();
  }
  // run migration from v3 to v4
  if(last?.major == 3 && current.major == 4){
    // TODO add migration of word lists from v3 to v4
  }

}
