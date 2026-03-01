import 'package:language_processing/language_processing.dart';
import 'package:language_processing/src/parse_result.dart';
import 'package:mecab_for_dart/mecab_dart.dart';



ParseResult parse(String text, Mecab mecab, ProcessorOptions options) {

  final segments = <String?>[];
  final tokens = <String?>[];
  final readings = <String?>[];
  final pos = <List<String?>>[];

  final nodes = mecab.parse(text);
  
  for (final node in nodes) {
    if (node.surface == 'EOS') continue;
    int l = node.features.length;

    segments.add(node.surface);
    
    if(l > 4) {
      pos.add(node.features.sublist(0, 4));
    }
    else {
      pos.add([]);
    }

    if(l > 10) {
      tokens.add(node.features[10]);
    }
    else {
      tokens.add(null);
    }
    
    if(l > 20) {
      readings.add(node.features[20]);
    }
    else {
      readings.add(null);
    }
    
  }

  return ParseResult(
    segments: segments,
    tokens: tokens,
    readings: readings,
    pos: pos
  );
}