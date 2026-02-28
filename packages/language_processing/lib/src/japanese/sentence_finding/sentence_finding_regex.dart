import '../japanese_string_operations.dart';

// Finds all sentences in the given `text` using a RegExp for estimation
List<String> findSentences(String text){

  return sentenceRegex.allMatches(text)
    .map((match) => match.group(0) ?? "").toList();

}
