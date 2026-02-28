import 'package:mecab_for_dart/mecab_dart.dart';



String? tokenize(String text, Mecab mecab) {
  if (text.isEmpty) return null;

  List<String> tokens = mecab.parse(text).map((e) => e.surface).toList();
  
  if (tokens.isNotEmpty) tokens = tokens.sublist(0, tokens.length - 1);
  
  String joinedTokens = tokens.join(" ");
  return joinedTokens == text ? null : joinedTokens;
}