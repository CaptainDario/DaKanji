import 'package:css_inline_flutter/css_inline_flutter.dart';



/// This function initializes the DaKanjiDb UI package.
/// 
/// IMPORTANT:
///   Needs to be called before using any other functionality from this package.
Future initDaKanjiDbUi() async {

  await RustLib.init();

}