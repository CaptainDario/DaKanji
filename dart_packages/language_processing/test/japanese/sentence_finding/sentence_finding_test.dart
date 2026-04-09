import 'package:language_processing/src/japanese/sentence_finding/sentence_finding_scan.dart' as scan;
import 'package:test/test.dart';

import '../paragraph_finding/paragraph_finding_test_cases.dart';

void main() {
  
  group('Sentence Finding - Manual Scanner', () {
    for (final tc in sentenceCases) {
      test(tc.description, () {
        final result = scan.findSentences(tc.input);

        expect(result, hasLength(tc.expected.length), 
            reason: 'Mismatch in number of sentences found.');
        
        for (var i = 0; i < result.length; i++) {
          expect(result[i].text, tc.expected[i].text, 
              reason: 'Text mismatch at segment $i');
          expect(result[i].start, tc.expected[i].start, 
              reason: 'Start index mismatch at segment $i');
          expect(result[i].end, tc.expected[i].end, 
              reason: 'End index mismatch at segment $i');
        }
      });
    }
  });

}