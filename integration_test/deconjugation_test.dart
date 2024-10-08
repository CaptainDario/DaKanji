// Import the test package and Counter class

import 'package:da_kanji_mobile/application/japanese_text_processing/deconjugate.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tuple/tuple.dart';

import 'test_utils.dart';



List<Tuple2<String, String>> verbs = [
  const Tuple2("", ""),
  const Tuple2("fashion", ""),

  const Tuple2("食べる", "食べる"),
  const Tuple2("食べない", "食べる"),
  const Tuple2("食べた", "食べる"),
  const Tuple2("食べなかった", "食べる"),
  const Tuple2("食べて", "食べる"),
  const Tuple2("食べなくて", "食べる"),
  const Tuple2("食べないで", "食べる"),
  const Tuple2("食べよう", "食べる"),
  const Tuple2("食べまい", "食べる"),
  const Tuple2("食べろ", "食べる"),
  const Tuple2("食べるな", "食べる"),
  const Tuple2("食べれば", "食べる"),
  const Tuple2("食べなければ", "食べる"),
  const Tuple2("食べたら", "食べる"),
  const Tuple2("食べなかったら", "食べる"),
  const Tuple2("食べられる", "食べる"),
  const Tuple2("食べられない", "食べる"),
  const Tuple2("食べさせる", "食べる"),
  const Tuple2("食べさせない", "食べる"),
  const Tuple2("食べさせられる", "食べる"),
  const Tuple2("食べさせられない", "食べる"),
  const Tuple2("食べている", "食べる"),
  const Tuple2("食べます", "食べる"),

  const Tuple2("飲む", "飲む"),
  const Tuple2("飲まない", "飲む"),
  const Tuple2("飲んだ", "飲む"),
  const Tuple2("飲まなかった", "飲む"),
  const Tuple2("飲んで", "飲む"),
  const Tuple2("飲まなくて", "飲む"),
  const Tuple2("飲まないで", "飲む"),
  const Tuple2("飲もう", "飲む"),
  const Tuple2("飲むまい", "飲む"),
  const Tuple2("飲め", "飲む"),
  const Tuple2("飲むな", "飲む"),
  const Tuple2("飲めば", "飲む"),
  const Tuple2("飲まなければ", "飲む"),
  const Tuple2("飲んだら", "飲む"),
  const Tuple2("飲まなかったら", "飲む"),
  //const Tuple2("飲める", "飲む"),
  //const Tuple2("飲めない", "飲む"),
  const Tuple2("飲まれる", "飲む"),
  const Tuple2("飲まれない", "飲む"),
  const Tuple2("飲ませる", "飲む"),
  const Tuple2("飲ませない", "飲む"),
  const Tuple2("飲んでいる", "飲む"),
  const Tuple2("飲ませられる", "飲む"),
  const Tuple2("飲ませられない", "飲む"),

  const Tuple2("思い始める", "思い始める"),
  const Tuple2("思い始めさせられる", "思い始める"),
  const Tuple2("きられる", "きる"),
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
      String deconjugated = deconjugate(verbs[i].item1);

      expect(deconjugated, verbs[i].item2);  
    }
    
  });

}