
import 'package:dakanji_db_core/database/example/example_entry.dart';
import 'package:dakanji_db_core/database/example/example_entry_translation.dart';
import 'package:language_processing/language_processing.dart';

import '../dictionary_test_variables.dart';


List<(String, List<Iso639_3>)> exampleSentencesTestQueries = [
  ("勉強", [Iso639_3.eng, Iso639_3.deu]),
  ("勉強", [Iso639_3.deu]),
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
          languageCode: "deu"
        ),
        ExampleEntryTranslation(
          translation: "I studied a lot today.",
          languageCode: "eng"
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
          languageCode: "deu"
        ),
        ExampleEntryTranslation(
          translation: "I studied a lot today.",
          languageCode: "eng"
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
          languageCode: "deu"
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
          languageCode: "deu"
        )
      ]
    )
  ]
];