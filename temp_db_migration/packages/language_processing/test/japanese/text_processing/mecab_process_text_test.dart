import 'package:da_db_shared/paths.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:language_processing/src/japanese/mecab_word_selection/select_word.dart';
import 'package:language_processing/src/parse_result.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';

import 'mecab_process_text_test_cases.dart';

void main() {
  late Mecab mecab;
  late KanaKit kanaKit;

  setUpAll(() async {
    kanaKit = const KanaKit();
    mecab = await Mecab.create(dictDir: mecabDicPath);
  });

  group('processText - High Level Parsing', () {
    for (final testCase in processTextTestCases) {
      
      final description = testCase['description'] as String;
      final input = testCase['input'] as String;
      final expectedSegments = testCase['expectedSegments'] as List<String>;
      final expectedTokens = testCase['expectedTokens'] as List<String>;
      final expectedReadings = testCase['expectedReadings'] as List<String>;
      final expectedPosLengths = testCase['expectedPosLengths'] as int;

      test(description, () {
        final ParseResult result = processText(input, mecab, kanaKit);

        // Assert length synchronicity across all ParseResult properties
        expect(result.surfaces.length, equals(expectedSegments.length), 
            reason: 'Segment length mismatch.');
        expect(result.tokens.length, equals(expectedSegments.length), 
            reason: 'Tokens list must perfectly align with segments.');
        expect(result.readings.length, equals(expectedSegments.length), 
            reason: 'Readings list must perfectly align with segments.');
        expect(result.pos.length, equals(expectedPosLengths), 
            reason: 'POS list must perfectly align with segments.');

        // Assert exact content matching
        expect(result.surfaces, equals(expectedSegments));
        expect(result.tokens, equals(expectedTokens));
        expect(result.readings, equals(expectedReadings));
      });
    }
  });
}