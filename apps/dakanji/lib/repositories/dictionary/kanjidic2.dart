

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/isar/isars.dart';

/// Searches in KanjiVG the matching entries to `kanjis` and returns them
List<Kanjidic2> findMatchingKanjiDic2(List<String> kanjis){
  
  if(kanjis.isEmpty) {
    return [];
  }
    
  return GetIt.I<Isars>().dictionary.kanjidic2s.where()
    .anyOf(kanjis, (q, element) => q.characterEqualTo(element)
  ).findAllSync().toList();
}
