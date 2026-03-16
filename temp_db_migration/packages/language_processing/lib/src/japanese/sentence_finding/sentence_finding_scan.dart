import 'package:language_processing/src/japanese/japanese_string_operations.dart';
import 'package:language_processing/src/text_segment.dart';

/// Finds all sentences in the given text, safely ignoring punctuation 
/// that occurs inside quotes or brackets.
List<TextSegment> findSentences(String text) {
  final List<TextSegment> sentences = [];
  final StringBuffer currentBuffer = StringBuffer();
  
  int bracketDepth = 0;
  int sentenceStartIdx = 0; // Track the start of the current segment
  
  const String sentenceEnders = '。！？!?\n';

  for (int i = 0; i < text.length; i++) {
    final String char = text[i];
    currentBuffer.write(char);

    if (japaneseOpenParantheses.contains(char)) {
      bracketDepth++;
    } else if (japaneseCloseParantheses.contains(char)) {
      bracketDepth = (bracketDepth > 0) ? bracketDepth - 1 : 0;
    }

    // Check for sentence end
    if (bracketDepth == 0 && sentenceEnders.contains(char)) {
      
      // Look ahead for trailing quotes (e.g., 。」)
      while (i + 1 < text.length && japaneseCloseParantheses.contains(text[i + 1])) {
        i++;
        currentBuffer.write(text[i]);
      }
      
      final content = currentBuffer.toString();
      if (content.trim().isNotEmpty) {
        // match.end is usually exclusive, so i + 1 is the correct boundary
        sentences.add(TextSegment(content.trim(), sentenceStartIdx, i + 1));
      }
      
      currentBuffer.clear();
      sentenceStartIdx = i + 1; // The next sentence starts after the current end
    }
  }

  // Handle leftover text
  if (currentBuffer.isNotEmpty) {
    final content = currentBuffer.toString();
    if (content.trim().isNotEmpty) {
      sentences.add(TextSegment(content.trim(), sentenceStartIdx, text.length));
    }
  }

  return sentences;
}