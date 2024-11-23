import 'dart:io';

import 'package:dakanji_db/conversion/kanji_vg.dart';





void main() async {

  // File path
  final folderPath = 'input_files/kanji/';
  convertKanjiVGFolderToMap(folderPath);

}
