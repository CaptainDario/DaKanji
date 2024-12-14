// Import the test package and Counter class

import 'package:da_kanji_mobile/application/japanese_text_processing/deconjugate.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tuple/tuple.dart';

import 'test_utils.dart';



const List<Tuple2<String, String>> verbs = [
  Tuple2("", ""),
  Tuple2("fashion", ""),

  Tuple2("食べる", "食べる"),
  Tuple2("食べない", "食べる"),
  Tuple2("食べた", "食べる"),
  Tuple2("食べなかった", "食べる"),
  Tuple2("食べて", "食べる"),
  Tuple2("食べなくて", "食べる"),
  Tuple2("食べないで", "食べる"),
  Tuple2("食べよう", "食べる"),
  Tuple2("食べまい", "食べる"),
  Tuple2("食べろ", "食べる"),
  Tuple2("食べるな", "食べる"),
  Tuple2("食べれば", "食べる"),
  Tuple2("食べなければ", "食べる"),
  Tuple2("食べたら", "食べる"),
  Tuple2("食べなかったら", "食べる"),
  Tuple2("食べられる", "食べる"),
  Tuple2("食べられない", "食べる"),
  Tuple2("食べさせる", "食べる"),
  Tuple2("食べさせない", "食べる"),
  Tuple2("食べさせられる", "食べる"),
  Tuple2("食べさせられない", "食べる"),
  Tuple2("食べている", "食べる"),
  Tuple2("食べます", "食べる"),
  Tuple2("食べています", "食べる"),

  Tuple2("飲む", "飲む"),
  Tuple2("飲まない", "飲む"),
  Tuple2("飲んだ", "飲む"),
  Tuple2("飲まなかった", "飲む"),
  Tuple2("飲んで", "飲む"),
  Tuple2("飲まなくて", "飲む"),
  Tuple2("飲まないで", "飲む"),
  Tuple2("飲もう", "飲む"),
  Tuple2("飲むまい", "飲む"),
  Tuple2("飲め", "飲む"),
  Tuple2("飲むな", "飲む"),
  Tuple2("飲めば", "飲む"),
  Tuple2("飲まなければ", "飲む"),
  Tuple2("飲んだら", "飲む"),
  Tuple2("飲まなかったら", "飲む"),
  Tuple2("飲める", "飲む"),
  Tuple2("飲めない", "飲む"),
  Tuple2("飲まれる", "飲む"),
  Tuple2("飲まれない", "飲む"),
  Tuple2("飲ませる", "飲む"),
  Tuple2("飲ませない", "飲む"),
  Tuple2("飲んでいる", "飲む"),
  Tuple2("飲ませられる", "飲む"),
  Tuple2("飲ませられない", "飲む"),

  Tuple2("思い始める", "思い始める"),
  Tuple2("思い始めさせられる", "思い始める"),
  Tuple2("きられる", "きる"),

  Tuple2("可愛かったです", "可愛い"),
  Tuple2("大変だった", "大変"),
  Tuple2("せんせい", "せんせい"),
  Tuple2("先生", "先生"),
];


void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Deconjugation test", (WidgetTester tester) async {

    await initDaKanjiTest(tester, initCallback: () {
      GetIt.I<UserData>().showOnboarding = false;
      GetIt.I<UserData>().showTutorialDictionary = false;
      GetIt.I<UserData>().showTutorialDrawing    = false;
      GetIt.I<Settings>().drawing.emptyCanvasAfterDoubleTap = false;
    });

    for (int i = 0; i < verbs.length; i++) {
      List<String> deconjugated = getDeconjugatedTerms(verbs[i].item1);

      expect(deconjugated, verbs[i].item2);  
    }
    
  });

}