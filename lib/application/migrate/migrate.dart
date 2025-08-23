// Project imports:
import 'package:da_kanji_mobile/application/migrate/v3_to_v4.dart';
import 'package:da_kanji_mobile/entities/releases/version.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Checks if any migration is necessary and if so runs the them
Future migrate(Version? last, Version current) async {

  // while on >= v3.5.0 backup all word list data to text files to allow 
  // migration to v4
  if(current.major == 3){
    //storeWordListsAsTextFilesForMigration();
  }
  // as some users cannot start the app on v3.5.2 because of shared preferences
  // delete it when upgrading to a newer version
  if(current.major == 3 && current.minor >= 5 && current.patch >= 3
    && last != null
    && last.major == 3 && last.minor <= 5 && last.patch <= 2){
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  // run migration from v3 to v4
  if(last?.major == 3 && current.major == 4){
    // TODO v4: add migration of word lists from v3 to v4
  }

}
