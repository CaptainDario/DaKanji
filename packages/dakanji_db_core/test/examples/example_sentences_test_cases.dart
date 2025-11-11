
import 'package:dakanji_db_core/database/example/example_entry.dart';
import 'package:dakanji_db_core/database/example/example_entry_translation.dart';
import 'package:language_processing/iso/iso_table.dart';

import '../dictionary_test_variables.dart';


List<(String, List<Iso639_1>)> exampleSentencesTestQueries = [
  ("勉強", [Iso639_1.en, Iso639_1.de]),
  ("勉強", [Iso639_1.de]),
];

List<List<ExampleEntry>> exampleSentenceTestExpectedValues = [
  [
    ExampleEntry(
      id: 0,
      indexEntry: exampleSentencesIndexEntry,
      example: "今日よく勉強した。",
      translations: [
        ExampleEntryTranslation(
          translation: "Ich habe heute viel gelernt.",
          languageCode: "de"
        ),
        ExampleEntryTranslation(
          translation: "I studied a lot today.",
          languageCode: "en"
        )
      ]
    ),
    ExampleEntry(
      id: 0,
      indexEntry: exampleSentencesIndexEntry,
      example: "今日よく勉強しました。",
      translations: [
        ExampleEntryTranslation(
          translation: "Ich habe heute viel gelernt.",
          languageCode: "de"
        ),
        ExampleEntryTranslation(
          translation: "I studied a lot today.",
          languageCode: "en"
        )
      ]
    )
  ],
  [
    ExampleEntry(
      id: 0,
      indexEntry: exampleSentencesIndexEntry,
      example: "今日よく勉強した。",
      translations: [
        ExampleEntryTranslation(
          translation: "Ich habe heute viel gelernt.",
          languageCode: "de"
        )
      ]
    ),
    ExampleEntry(
      id: 0,
      indexEntry: exampleSentencesIndexEntry,
      example: "今日よく勉強しました。",
      translations: [
        ExampleEntryTranslation(
          translation: "Ich habe heute viel gelernt.",
          languageCode: "de"
        )
      ]
    )
  ]
];