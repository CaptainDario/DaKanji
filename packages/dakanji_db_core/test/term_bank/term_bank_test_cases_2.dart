// This list should contain the search term that corresponds to the expectations above.
import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';

final int dictId = 1;

final termBankTestCases2 = [
  '発条',
];

final termBankTestCaseExpectations2 = [
  // Test case for "発条"
  [
    TermBankV3Entry(
      termBankV3TableId: 1,
      indexId: dictId,
      term: '発条',
      reading: 'ばね',
      definitionTags: [],
      ruleIdentifiers: [],
      popularity: 0,
      definitions: [
        'spring',
        'spring (in one\'s legs); bounce',
        'springboard; impetus',
      ],
      structuredContentDefinitions: [ // TODO
        '{"type":"definition","content":"spring"}',
        '{"type":"definition","content":"spring (in one\'s legs); bounce"}',
        '{"type":"definition","content":"springboard; impetus"}',
      ],
      sequenceNumber: 1099490,
      tags: [],
    ),
  ],
];