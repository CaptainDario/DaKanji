import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/audio/audio_parser_context.dart';
import 'package:drift/drift.dart';



Future importMediaFile(
  String path, Uint8List mediaContent, int indexId, DaKanjiDB db, AudioParserContext
  ? aC
) async {

  List<Variable> vars = [
    Variable.withString(path),
    Variable.withBlob(mediaContent),
    Variable.withInt(indexId),
  ];
  (String, String) t = ('', '');
  if(aC != null){
    vars = <Variable>[Variable.withInt(++aC.currentMaxMediaId)] + vars;
    t = ('id, ', '?, ');
  }
  
  await db.customInsert(
    'INSERT INTO media_table_view (${t.$1}path, data, index_id) VALUES (${t.$2}?, ?, ?)',
    variables: vars,
  );

}
