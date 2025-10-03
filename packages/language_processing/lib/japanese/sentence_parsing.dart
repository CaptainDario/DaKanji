import 'package:mecab_for_dart/mecab_dart.dart';



Future<String> parseSentenceUsingMecab(String sentence, Mecab mecab) async {

  List<TokenNode> parsed = mecab.parse(sentence);
  String tokenized = "";
  for (int i = 0; i < parsed.length; i++) {
    if(parsed[i].features.isEmpty) continue;

    print("lkasgdlkjas ${parsed[i].surface} -> ${parsed[i].features} -> ${parsed[i].features[10]}");
    tokenized += "${parsed[i].features[10]} ";
  }

  return tokenized;

}