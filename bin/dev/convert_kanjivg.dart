import 'dart:io';

import 'package:dakanji_db/conversion/kanji_vg.dart';
import 'package:tuple/tuple.dart';
import './setup_conversion.dart';



void main() async {

  // setup 
  Tuple2 t = setupConversion(ConversionTarget.sample);
  final db = t.item2;

  // convert krad / radk file
  // 30 mb without compression
  //  mb zlib
  // 12 mb bzip
  // 11.7 gzip
  final folderPath = 'input_files/kanji/';
  await addKanjiVGToDB(folderPath, db);

  exit(0);

}
