import 'dart:io';

import 'package:dakanji_db/conversion/radicals.dart';
import './setup_conversion.dart';
import 'package:tuple/tuple.dart';



void main() async {

  // setup 
  Tuple2 t = setupConversion(ConversionTarget.sample);
  final db = t.item2;

  // convert krad / radk file
  final radicalPath = 'input_files/';
  await convertRadicals(radicalPath, db);

  exit(0);

}
