/// matches full and half width punctuations
const String punctuations = "。|？|！|\\.|\\!|\\?";
/// matches japanese ending parantheses
const String japaneseParantheses = "』|」";
/// matches any whitespace
const String anyWhiteSpace = "\\s|　";
/// Regex that matches a sentence
RegExp sentenceRegex = RegExp(
  "(?:[^$anyWhiteSpace])+?(?:(?!($punctuations)$japaneseParantheses)$punctuations|\\n|\$)",
  multiLine: true
);