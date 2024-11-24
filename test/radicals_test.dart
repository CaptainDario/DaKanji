import 'dart:io';

import 'package:dakanji_db/conversion/radicals.dart';
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

import '../bin/dev/setup_conversion.dart';



void main() {
  test('Radical conversion', () async {
    
    // setup 
    Tuple2<Directory, DaKanjiDB> t = setupConversion(ConversionTarget.sample);
    final DaKanjiDB db = t.item2;

    // convert krad / radk file
    final kradPath = 'input_files/kradzip/kradfile2';
    final radkPath = 'input_files/kradzip/radkfilex';
    await convertRadicals(radkPath, kradPath, db);

    //db.dao

  });
}
