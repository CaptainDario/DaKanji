import 'package:language_processing/src/japanese/paragraph_finding/paragraph_finding.dart';
import 'package:test/test.dart';

import 'paragraph_finding_test_cases.dart';

void main() {
  
  group('findParagraphs', () {
    for (final tc in paragraphCases) {
      test(tc.description, () {
        final result = findParagraphs(tc.input);

        expect(result, hasLength(tc.expected.length), 
            reason: 'Mismatch in number of paragraphs found.');
        
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