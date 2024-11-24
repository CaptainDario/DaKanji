import 'dart:io';

import 'package:dakanji_db/conversion/radicals.dart';
import './setup_conversion.dart';
import 'package:tuple/tuple.dart';



void main() async {

  // setup 
  Tuple2 t = setupConversion(ConversionTarget.sample);
  final db = t.item2;

  // convert krad / radk file
  final kradPath = 'input_files/kradzip/kradfile2';
  final radkPath = 'input_files/kradzip/radkfilex';
  await convertRadicals(radkPath, kradPath, db);

  exit(0);

}
