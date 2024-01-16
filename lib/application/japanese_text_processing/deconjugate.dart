// Package imports:
import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_dart/mecab_dart.dart';

/// Deconjugates the given `text` if it is a conjugated verb / adj 
/// or a noun with copula
String deconjugate(String text){

  String ret = "";

  if(GetIt.I<KanaKit>().isJapanese(text)){
    List<TokenNode> nodes = GetIt.I<Mecab>().parse(text)..removeLast();
    
    for (int i = 0; i < nodes.length; i++) {
      // if the input is a verb / adjective / noun
      if((nodes[i].features[0] == "動詞" || nodes[i].features[0] == "形容詞" ||
        nodes[i].features[0] == "形状詞" || nodes[i].features[0] == "名詞")
        // and the next pos is a conjugation
        && nodes.length > i+1 && nodes[i+1].features[0].contains("助動詞")
        )
      {
        // convert to dictionary form
        ret += nodes[i].features[6];
        
        // ignore all conjugation terminations
        i++;
        while(nodes.length > i && nodes[i].features[0].contains("助動詞")){
          i++;
        }
      }
      else{
        ret += nodes[i].surface;
      }
    }
  }

  return ret;
}
