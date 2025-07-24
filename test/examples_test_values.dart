
import 'package:dakanji_db/database/example/example_entry.dart';


List<String> examplesTestQueries = ["勉強"];

List<ExampleEntry> examplesTestExpected = [
  ExampleEntry(
    example: "今日よく勉強した。",
    tokenizedExample: "今日 よく 勉強 する た 。",
    translations: [])
];