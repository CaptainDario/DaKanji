import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:drift/drift.dart';



Future importMediaFile(
  String path, Uint8List mediaContent, int indexId, DaKanjiDB db, int? insertId
) async {

  List<Variable> vars = [
    Variable.withString(path),
    Variable.withBlob(mediaContent),
    Variable.withInt(indexId),
  ];
  (String, String) t = ('', '');
  if(insertId != null){
    vars = <Variable>[Variable.withInt(insertId)] + vars;
    t = ('id, ', '?, ');
  }
  
  await db.customInsert(
    'INSERT INTO media_table_view (${t.$1}path, data, index_id) VALUES (${t.$2}?, ?, ?)',
    variables: vars,
  );

}
