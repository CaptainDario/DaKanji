import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;



Future importMediaFile(
  String filePath, Uint8List mediaContent, int indexId, DaKanjiDB db, int? insertId
) async {

  String name = p.basename(filePath);
  String path = p.dirname(filePath);

  List<Variable> vars = [
    Variable<String>(path),
    Variable<String>(name),
    Variable.withBlob(mediaContent),
    Variable.withInt(indexId),
  ];
  (String, String) t = ('', '');
  if(insertId != null){
    vars = <Variable>[Variable.withInt(insertId)] + vars;
    t = ('id, ', '?, ');
  }
  
  await db.customInsert(
    'INSERT INTO media_table_view (${t.$1}path, name, data, index_id) VALUES (${t.$2}?, ?, ?, ?)',
    variables: vars,
  );

}
