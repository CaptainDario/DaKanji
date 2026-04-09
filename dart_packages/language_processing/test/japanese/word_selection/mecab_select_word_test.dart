import 'package:da_db_shared/da_db_shared.dart';
import 'package:language_processing/src/japanese/mecab_text_processing/mecab_process_text.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';

import 'mecab_select_word_test_cases.dart';



void main() {
  late Mecab mecab;

  setUpAll(() async {
    mecab = await Mecab.create(dictDir: mecabDicPath);
  });

  group('selectMaxLengthWord & posFromTokeNodes - Low Level Grouping', () {
    for (final testCase in selectWordTestCases) {
      
      final description = testCase['description'] as String;
      final input = testCase['input'] as String;
      final expectedGroupedNodesCount = testCase['expectedGroupedNodesCount'] as int;
      final expectedCombinedSurface = testCase['expectedCombinedSurface'] as String;
      final expectedPrimaryPos = testCase['expectedPrimaryPos'] as String;

      test(description, () {
        // Step 1: Parse the string to generate the raw TokenNodes list
        List<TokenNode> rawNodes = mecab.parse(input);
        if (rawNodes.isNotEmpty && rawNodes.last.surface == 'EOS') {
          rawNodes.removeLast();
        }

        // Step 2: Feed the nodes to the selection logic
        final List<TokenNode> groupedNodes = selectMaxLengthWord(rawNodes);

        // Step 3: Extract the combined string and POS tags
        final String combinedSurface = groupedNodes.map((e) => e.surface).join();
        final List<String> posTags = posFromTokeNodes(groupedNodes);

        // Assert logical boundaries
        expect(groupedNodes.length, equals(expectedGroupedNodesCount),
            reason: 'Failed to group the correct number of grammatical nodes.');
        
        // Assert surface text grouping
        expect(combinedSurface, equals(expectedCombinedSurface),
            reason: 'Combined surface text does not match expectations.');

        // Assert POS resolution (specifically checking index 0 for the primary POS)
        expect(posTags.isNotEmpty, isTrue, 
            reason: 'POS tag list should not be empty.');
        expect(posTags[0], equals(expectedPrimaryPos),
            reason: 'Failed to correctly resolve the primary Part of Speech.');
      });
    }
  });
}