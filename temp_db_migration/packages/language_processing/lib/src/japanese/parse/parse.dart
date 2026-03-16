import 'package:language_processing/language_processing.dart';
import 'package:language_processing/src/parse_result.dart';
import 'package:mecab_for_dart/mecab_dart.dart';



ParseResult parse(String text, Mecab mecab, ProcessorOptions options) {

  final surfaces = <String?>[];
  final tokens = <String?>[];
  final readings = <String?>[];
  final pos = <List<String?>>[];

  final nodes = mecab.parse(text);
  
  for (final node in nodes) {
    if (node.surface == 'EOS') continue;
    int l = node.features.length;

    surfaces.add(node.surface);
    
    if(l > UniDicFields.pos4) {
      pos.add(node.features.sublist(0, UniDicFields.pos4+1));
    }
    else {
      pos.add([]);
    }

    if(l > UniDicFields.orthBase) {
      tokens.add(node.features[UniDicFields.orthBase]);
    }
    else {
      tokens.add(null);
    }
    
    if(l > UniDicFields.kana) {
      readings.add(node.features[UniDicFields.kana]);
    }
    else {
      readings.add(null);
    }
    
  }

  return ParseResult(
    surfaces: surfaces,
    tokens: tokens,
    readings: readings,
    pos: pos
  );
}