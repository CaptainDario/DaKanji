
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';

int dictId = 1;

/// ----------------------------------------------------------------------------
/// Test cases for term_bank_1.json
final termBankTestCases1 = [
  "打",
  "打つ",
  "打ち込む",
  "画像",
  "読む",
  "強み",
  "テキスト",
  "お手前",
  "番号",
  "中腰",
  "所業",
  "土木工事",
  "好き",
  "内容",
  "構造",
  "のたまう",
  "のたもうた",
  "３９",
  "凄い",
  "English",
  "language",
  "ＵＳＢ",
  "마시다",
  "自重"
];

/// kanjiMetaBankV3 test case expected values
final termBankTestCaseExpectations1 = [
  // Test case for "打"
  [
    TermBankV3Entry(
      indexId: dictId,
      term: "打",
      reading: "だ",
      definitionTags: ["n"],
      ruleIdentifiers: ["n"],
      popularity: 1,
      definitions: ["da definition 1", "da definition 2"],
      sequenceNumber: 1,
      tags: [
        TagBankV3Entry(
          indexId: dictId,
          name: "E1",
          category: "default",
          sortingOrder: 0,
          notes: "example tag 1",
          score: 0)
      ]
    ),
    TermBankV3Entry(
      indexId: dictId,
      term: "打",
      reading: "ダース",
      definitionTags: ["n", "abbr"],
      ruleIdentifiers: ["n"],
      popularity: 1,
      definitions: ["daasu definition 1", "daasu definition 2"],
      sequenceNumber: 2,
      tags: [
        TagBankV3Entry(
          indexId: dictId,
          name: "E1",
          category: "default",
          sortingOrder: 0,
          notes: "example tag 1",
          score: 0
        )
      ]
    ),
  ],
  // Test case for "打つ"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "打つ",
        reading: "うつ",
        definitionTags: ["vt"],
        ruleIdentifiers: ["v5"],
        popularity: 10,
        definitions: ["utsu definition 1", "utsu definition 2"],
        sequenceNumber: 3,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E1",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 1",
              score: 0)
        ]),
    TermBankV3Entry(
        indexId: dictId,
        term: "打つ",
        reading: "うつ",
        definitionTags: ["vt"],
        ruleIdentifiers: ["v5"],
        popularity: 1,
        definitions: ["utsu definition 3", "utsu definition 4"],
        sequenceNumber: 3,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E2",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 2",
              score: 0)
        ]),
    TermBankV3Entry(
        indexId: dictId,
        term: "打つ",
        reading: "ぶつ",
        definitionTags: ["vt"],
        ruleIdentifiers: ["v5"],
        popularity: 10,
        definitions: ["butsu definition 1", "butsu definition 2"],
        sequenceNumber: 3,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E1",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 1",
              score: 0)
        ]),
    TermBankV3Entry(
        indexId: dictId,
        term: "打つ",
        reading: "ぶつ",
        definitionTags: ["vt"],
        ruleIdentifiers: ["v5"],
        popularity: 1,
        definitions: ["butsu definition 3", "butsu definition 4"],
        sequenceNumber: 3,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E2",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 2",
              score: 0)
        ]),
  ],
  // Test case for "打ち込む"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "打ち込む",
        reading: "うちこむ",
        definitionTags: ["vt"],
        ruleIdentifiers: ["v5"],
        popularity: 10,
        definitions: ["uchikomu definition 1", "uchikomu definition 2"],
        sequenceNumber: 4,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E1",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 1",
              score: 0)
        ]),
    TermBankV3Entry(
        indexId: dictId,
        term: "打ち込む",
        reading: "うちこむ",
        definitionTags: ["vt"],
        ruleIdentifiers: ["v5"],
        popularity: 1,
        definitions: ["uchikomu definition 3", "uchikomu definition 4"],
        sequenceNumber: 4,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E2",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 2",
              score: 0)
        ]),
    TermBankV3Entry(
        indexId: dictId,
        term: "打ち込む",
        reading: "ぶちこむ",
        definitionTags: ["vt"],
        ruleIdentifiers: ["v5"],
        popularity: 10,
        definitions: ["buchikomu definition 1", "buchikomu definition 2"],
        sequenceNumber: 4,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E1",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 1",
              score: 0)
        ]),
    TermBankV3Entry(
        indexId: dictId,
        term: "打ち込む",
        reading: "ぶちこむ",
        definitionTags: ["vt"],
        ruleIdentifiers: ["v5"],
        popularity: 1,
        definitions: ["buchikomu definition 3", "buchikomu definition 4"],
        sequenceNumber: 4,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E2",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 2",
              score: 0)
        ]),
  ],
  // Test case for "画像"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "画像",
        reading: "がぞう",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 1,
        definitions: ["gazou definition 1", "gazou definition 2"],
        sequenceNumber: 5,
        tags: [
          TagBankV3Entry(
              indexId: dictId, 
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E1",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 1",
              score: 0)
        ]),
  ],
  // Test case for "読む"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "読む",
        reading: "よむ",
        definitionTags: ["vt"],
        ruleIdentifiers: ["v5"],
        popularity: 100,
        definitions: ["to read"],
        sequenceNumber: 6,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E1",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 1",
              score: 0)
        ]),
  ],
  // Test case for "強み"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "強み",
        reading: "つよみ",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 90,
        definitions: ["strong point"],
        sequenceNumber: 7,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E1",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 1",
              score: 0)
        ]),
  ],
  // Test case for "テキスト"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "テキスト",
        reading: "テキスト",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 1,
        definitions: ["text definition 1", "text definition 2"],
        sequenceNumber: 8,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E1",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 1",
              score: 0)
        ]),
  ],
  // Test case for "お手前"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "お手前",
        reading: "おてまえ",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 1,
        definitions: ["otemae definition"],
        sequenceNumber: 9,
        tags: []),
  ],
  // Test case for "番号"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "番号",
        reading: "ばんごう",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 1,
        definitions: ["bangou definition"],
        sequenceNumber: 10,
        tags: []),
  ],
  // Test case for "中腰"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "中腰",
        reading: "ちゅうごし",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 1,
        definitions: ["chuugoshi definition"],
        sequenceNumber: 11,
        tags: []),
  ],
  // Test case for "所業"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "所業",
        reading: "しょぎょう",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 1,
        definitions: ["shogyouu definition"],
        sequenceNumber: 12,
        tags: []),
  ],
  // Test case for "土木工事"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "土木工事",
        reading: "どぼくこうじ",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 1,
        definitions: ["dobokukouji definition"],
        sequenceNumber: 13,
        tags: []),
  ],
  // Test case for "好き"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "好き",
        reading: "すき",
        definitionTags: ["adj-na", "n"],
        ruleIdentifiers: [],
        popularity: 1,
        definitions: ["suki definition"],
        sequenceNumber: 14,
        tags: []),
  ],
  // Test case for "内容"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "内容",
        reading: "ないよう",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 35,
        definitions: [
          'naiyou definition 1',
          'naiyou definition 2',
          'naiyou definition 3',
          'naiyou definition 5: more content 1: more content 2: and and',
          'naiyou definition 6: 内 ( ない ) 容 ( よう )',
          'imageRendering=auto: 莢 莢 莢 imageRendering=pixelated: 莢 莢 莢 imageRendering=crisp-edges: 莢 莢 莢',
          'Image aspect ratio tests: あ あ あ あ あ あ あ あ',
          'Image alt text tests. 𬵪 = Unicode character 𬵪 = monochrome PNG 𬵪 = color PNG',
          'fontStyle:normal fontStyle:italic fontWeight:normal fontWeight:bold fontSize:xx-small fontSize:x-small fontSize:70% fontSize:smaller fontSize:small fontSize:medium fontSize:large fontSize:larger fontSize:130% fontSize:x-large fontSize:xx-large fontSize:xxx-large textDecorationLine:none textDecorationLine:underline textDecorationLine:overline textDecorationLine:line-through textDecorationLine:[underline,overline,line-through] baseline verticalAlign:baseline baseline verticalAlign:sub baseline verticalAlign:super baseline verticalAlign:text-top baseline verticalAlign:text-bottom baseline verticalAlign:middle baseline verticalAlign:top baseline verticalAlign:bottom',
          'br br',
          'Header 1 Header 2 Header 3 Header 4 Cell A1 Cell B1 Cell C1 Cell D1 Cell A2 Cell B2 Cell C2:D2 Cell A3 Cell B3 Cell B4 Cell C3:D3 Cell C4:D4 Cell A4 Cell A5 Cell A6 Cell A7 Footer 1 Footer 2 Footer 3 Footer 4',
          'margin inner margin',
          'text 1 text 2 text 3',
          'internal link 1 internal link 2 external link',
          'Unordered list item 1 Unordered list item 2 Unordered list item 3',
          'Ordered list item 1 Ordered list item 2 Ordered list item 3',
          'List item i List item ro List item ha',
          '【 Antonym 】 【 References and is referenced by 】 【 References 】 【 Referenced by 】',
          'まるいち まるに まるさん まるよん',
          '直次茶冷 (auto lang) 直次茶冷 (invalid lang) 直次茶冷 (lang=ja-JP) 直次茶冷 (lang=zh-CN) 直次茶冷 (lang=zh-TW)',
          '【 直次茶冷 】(default) 【 直次茶冷 】(lang=ja) 【 直次茶冷 】(lang=zh-CN) 【 直次茶冷 】(lang=zh-TW)',
          'JP SC TC ?? 直次茶冷 直次茶冷 直次茶冷 直次茶冷',
          'lang=ja applied to whole table 直次茶冷',
          'lang=zh-CN applied to whole table 直次茶冷',
        ],
        sequenceNumber: 100,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E1",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 1",
              score: 0)
        ]),
  ],
  // Test case for "構造"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "構造",
        reading: "こうぞう",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 35,
        definitions: [
          "kouzou definition 1",
          "kouzou definition 2",
          "kouzou definition 3 (構造)"
        ],
        sequenceNumber: 101,
        tags: [
          TagBankV3Entry(
              indexId: dictId,
              name: "P",
              category: "popular",
              sortingOrder: 0,
              notes: "popular term",
              score: 0),
          TagBankV3Entry(
              indexId: dictId,
              name: "E1",
              category: "default",
              sortingOrder: 0,
              notes: "example tag 1",
              score: 0)
        ]),
  ],
  // Test case for "のたまう"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "のたまう",
        reading: "のたまう",
        definitionTags: ["v5"],
        ruleIdentifiers: ["v5"],
        popularity: 1,
        definitions: ["notamau definition"],
        sequenceNumber: 15,
        tags: []),
  ],
  // Test case for "のたもうた"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "のたもうた",
        reading: "のたもうた",
        definitionTags: [],
        ruleIdentifiers: [],
        popularity: 1,
        definitions: ["のたまう → past"],
        sequenceNumber: 16,
        tags: []),
  ],
  // Test case for "３９"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "３９",
        reading: "さんきゅう",
        definitionTags: [],
        ruleIdentifiers: [],
        popularity: 1,
        definitions: ["sankyuu definition"],
        sequenceNumber: 17,
        tags: []),
  ],
  // Test case for "凄い"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "凄い",
        reading: "すごい",
        definitionTags: ["adj-i"],
        ruleIdentifiers: ["adj-i"],
        popularity: 1,
        definitions: ["sugoi definition"],
        sequenceNumber: 18,
        tags: []),
  ],
  // Test case for "English"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "English",
        reading: "",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 1,
        definitions: ["English definition"],
        sequenceNumber: 19,
        tags: []),
  ],
  // Test case for "language"
  [
    TermBankV3Entry(
        indexId: dictId, 
        term: "language",
        reading: "",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 1,
        definitions: ["language definition"],
        sequenceNumber: 20,
        tags: []),
  ],
  // Test case for "ＵＳＢ"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "ＵＳＢ",
        reading: "ユーエスビー",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 1,
        definitions: ["ＵＳＢ definition"],
        sequenceNumber: 21,
        tags: []),
  ],
  // Test case for "마시다"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "마시다",
        reading: "",
        definitionTags: ["v"],
        ruleIdentifiers: ["v"],
        popularity: 1,
        definitions: ["masida definition"],
        sequenceNumber: 22,
        tags: []),
  ],
  // Test case for "自重"
  [
    TermBankV3Entry(
        indexId: dictId,
        term: "自重",
        reading: "じちょう",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 1,
        definitions: ["jichou definition"],
        sequenceNumber: 23,
        tags: []),
    TermBankV3Entry(
        indexId: dictId,
        term: "自重",
        reading: "じじゅう",
        definitionTags: ["n"],
        ruleIdentifiers: ["n"],
        popularity: 2,
        definitions: ["jijuu definition"],
        sequenceNumber: 24,
        tags: []),
  ],
];
