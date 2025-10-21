
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part 'settings_dao.g.dart';



@DriftAccessor()
class SettingsDao extends DatabaseAccessor<DaKanjiDB> with _$SettingsDaoMixin {
  
  SettingsDao(super.db);
  

}