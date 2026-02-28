/// Finds all sentences in the given text, safely ignoring punctuation 
/// that occurs inside quotes or brackets.
List<String> findSentences(String text) {
  final List<String> sentences = [];
  final StringBuffer currentSentence = StringBuffer();
  
  // Track bracket depth to avoid splitting inside quotes
  int bracketDepth = 0;
  
  // Common Japanese opening/closing pairs
  const String openBrackets = '「『（【〈《〔';
  const String closeBrackets = '」』）】〉》〕';
  
  // Characters that constitute a sentence end
  const String sentenceEnders = '。！？!?\n';

  for (int i = 0; i < text.length; i++) {
    final String char = text[i];
    currentSentence.write(char);

    if (openBrackets.contains(char)) {
      bracketDepth++;
    } else if (closeBrackets.contains(char)) {
      bracketDepth = (bracketDepth > 0) ? bracketDepth - 1 : 0;
    }

    // If we hit an ender AND we are not inside a quote/bracket
    if (bracketDepth == 0 && sentenceEnders.contains(char)) {
      
      // Look ahead to capture trailing closing quotes like 。」
      while (i + 1 < text.length && closeBrackets.contains(text[i + 1])) {
        i++;
        currentSentence.write(text[i]);
      }
      
      final sentence = currentSentence.toString().trim();
      if (sentence.isNotEmpty) {
        sentences.add(sentence);
      }
      currentSentence.clear();
    }
  }

  // Catch any remaining text that didn't end in punctuation
  final leftover = currentSentence.toString().trim();
  if (leftover.isNotEmpty) {
    sentences.add(leftover);
  }

  return sentences;
}